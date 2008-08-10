require File.dirname(__FILE__) + '/spec_helper'

describe "Chord addition" do
  describe "adding C and G" do
    before(:each) do
      @c = Chord.new(:c, [0,4,7])
      @g = Chord.new(:g, [0,4,7])
    end
    
    it "yields CM9" do
      @cM9 = Chord.new(:c, [0,4,7,11,14])
      result = @c + @g
      result.should == @cM9
    end
  end

  describe "adding C and G-" do
    before(:each) do
      @c = Chord.new(:c, [0,4,7])
      @g = Chord.new(:g, [0,3,7])
    end
    
    it "yields C9" do
      @c9 = Chord.new(:c, [0,4,7,10,14])
      result = @c + @g
      result.should == @c9
    end
  end

end
