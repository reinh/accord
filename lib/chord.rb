class Pitch
  include Comparable
  
  def self.for(pitch)
    PITCH_CLASSES.detect { |pc| pc.name == pitch || pc.ord == pitch % 12 }
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
    str = name.to_s.upcase
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
    :m9   => 13,
    :M9   => 14
  }
  
  def self.[](name)
    INTERVALS[name]
  end
end

class Chord
  attr_reader :root
  def initialize(root, intervals)
    @root = Pitch.for(root)
    @intervals = intervals
  end
  
  def inspect
    name = root.to_s
    name << 'm' if minor?
    name << 'dim' if diminished?
    name << 'aug' if augmented?
    name
  end
  
  def major?
    return false if augmented?
    @intervals.include?(4)
  end
  
  def minor?
    return false if major? or diminished?
    @intervals.include?(3)
  end
  
  def diminished?
    @intervals.include?(3) and @intervals.include?(6)
  end
  
  def augmented?
    @intervals.include?(4) and @intervals.include?(8)
  end
  
  def seventh?
    @intervals.include?(10)
  end
  
  def minor_seventh?
    minor? and seventh?
  end
  
  def dominant_seventh?
    major? and seventh?
  end
  
  def major_seventh?
    major? and @intervals.include?(11)
  end
end
