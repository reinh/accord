class Pitch
  include Comparable
  
  def self.for(pitch)
    PITCH_CLASSES.detect { |pc| pc.ord == pitch % 12 }
  end
  
  def self.by_name(name)
    PITCH_CLASSES.detect {|pc| pc.name == name }
  end
  
  attr_reader :name, :ord
  
  def initialize(name, ord)
    @name, @ord = name, ord
  end
  
  def <=>(pc) ord <=> pc.ord end
    
  def sharp?
    [1,3,6,8,10].include? ord
  end
  
  def to_s
    str = name.to_s[0,1].upcase
    str << "#" if sharp?
    str
  end
  
  # Western pitch classes.
  PITCH_CLASSES = [
    new(:c, 0), new(:cs, 1),
    new(:d, 2), new(:ds, 3),
    new(:e, 4),
    new(:f, 5), new(:fs, 6),
    new(:g, 7), new(:gs, 8),
    new(:a, 9), new(:as, 10),
    new(:b, 11)
  ] unless defined?(PITCH_CLASSES)
end

module Interval
  INTERVALS = {
    :m2   => 1,
    :M2   => 2,
    :m3   => 3,
    :M3   => 4,
    :p4   => 5,
    :dim5 => 6,
    :p5   => 7,
    :aug5 => 8,
    :m6   => 8,
    :M6   => 9,
    :m7   => 10,
    :M7   => 11,
    :b9   => 13,
    :M9   => 14,
    :s9   => 15
  }
  
  def self.[](name)
    INTERVALS[name]
  end
end

module Qualities
  def minor?
    return false if major? or diminished?
    include?(:m3)
  end
  
  def major?
    return false if augmented?
    include?(:M3)
  end
  
  def diminished?
    include?(:m3, :dim5)
  end
  
  def augmented?
    include?(:M3, :aug5)
  end
  
  def seventh?
    return false if extensions?
    include?(:m7)
  end
  
  def minor_seventh?
    minor? and seventh?
  end
  
  def dominant_seventh?
    major? and seventh?
  end
  
  def major_seventh?
    return false if extensions?
    major? and include?(:M7)
  end
  
  def minor_major_seventh?
    return false if extensions?
    minor? and include?(:M7)
  end
  
  def extensions?
    flat_nine?   ||
    ninth?       ||
    sharp_nine?
  end
  
  def flat_nine?
    include?(:b9)
  end
  
  def ninth?
    include?(:M9)
  end
  
  def sharp_nine?
    include?(:s9)
  end
  
end

class Chord
  include Qualities
  
  attr_reader :root
  def initialize(root, intervals)
    @root = Pitch.by_name(root)
    @intervals = intervals
  end
  
  def include?(*names)
    names.all? do |name|
      @intervals.include?(Interval[name])
    end
  end
  
  def transposed_intervals(base_ord = 0)
    @intervals.map{|i| i + @root.ord + base_ord}
  end
  
  def inspect
    name = root.to_s
    name << '-'  if minor? # C-
    name << '-5' if diminished? # C-5
    name << '+5' if augmented?
    name << '7'  if seventh?
    name << 'M7' if include?(:M7)
    name << '7b9'if flat_nine?
    name << '9'  if ninth?
    name << '7+9'if sharp_nine?
    name
  end
end
