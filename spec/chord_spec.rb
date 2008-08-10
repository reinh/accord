require File.dirname(__FILE__) + '/spec_helper'

describe Pitch do
  describe "#to_s" do
    it "returns the correct letter" do
      Pitch.by_name(:c).to_s.should == "C"
    end
    
    it "returns the correct letter when sharp" do
      Pitch.by_name(:fs).to_s.should == "F#"
    end
  end
end

describe "C root", :shared => true do
  it 'has the root of "C"' do
    @chord.root.should == Pitch.new(:c, 0)
  end
end
describe "major", :shared => true do
  it "is major" do
    @chord.should be_major
  end
end
describe "minor", :shared => true do
  it "is minor" do
    @chord.should be_minor
  end
end
describe "seventh", :shared => true do
  it "has a seventh" do
    @chord.should be_seventh
  end
end
describe "ninth", :shared => true do
  it "is a ninth" do
    @chord.should be_ninth
  end  
end

describe "C" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "major"

  it 'inspects as "C"' do
    @chord.inspect.should == "C"
  end
end

describe "C-" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7])
  end

  it_should_behave_like "C root"
  it_should_behave_like "minor"
  
  it 'inspects as "C-"' do
    @chord.inspect.should == "C-"
  end
end

describe "C-5" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,6])
  end

  it_should_behave_like "C root"

  it "is diminished" do
    @chord.should be_diminished
  end
  
  it 'inspects as "C-5"' do
    @chord.inspect.should == "C-5"
  end
end

describe "C+5" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,8])
  end

  it_should_behave_like "C root"
  
  it "is augmented" do
    @chord.should be_augmented
  end
  
  it 'inspects as "C+5"' do
    @chord.inspect.should == "C+5"
  end
end

describe "C-7" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7,10])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "minor"
  it_should_behave_like "seventh"

  it "has a minor seventh" do
    @chord.should be_minor_seventh
  end
  
  it 'inspects as "C-7"' do
    @chord.inspect.should == 'C-7'
  end
end

describe "C7" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,10])
  end

  it_should_behave_like "C root"
  it_should_behave_like "major"
  it_should_behave_like "seventh"
  
  it "has a dominant seventh" do
    @chord.should be_dominant_seventh
  end
  
  it 'inspects as "C7"' do
    @chord.inspect.should == 'C7'
  end
end

describe "CM7" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,11])
  end

  it_should_behave_like "C root"
  it_should_behave_like "major"
  
  it "is a major seventh" do
    @chord.should be_major_seventh
  end
  
  it 'inspects as "CM7"' do
    @chord.inspect.should == 'CM7'
  end
end

describe "C-M7" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7,11])
  end

  it_should_behave_like "C root"
  it_should_behave_like "minor"
  
  it "has a major seventh" do
    @chord.include?(:M7).should be_true
  end
  
  it "is a minor major seventh" do
    @chord.should be_minor_major_seventh
  end
  
  it 'inspects as "C-M7"' do
    @chord.inspect.should == 'C-M7'
  end
end

describe "C9" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,10,14])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "major"
  it "is not a seventh" do
    @chord.should_not be_seventh
  end
  
  it_should_behave_like "ninth"
  
  it 'inspects as "C9"' do
    @chord.inspect.should == "C9"
  end  
end

describe "C-9" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7,10,14])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "minor"
  
  it "is not a seventh" do
    @chord.should_not be_seventh
  end
  
  it_should_behave_like "ninth"
  
  it 'inspects as "C-9"' do
    @chord.inspect.should == "C-9"
  end  
end

describe "C7-9" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,10,13])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "major"
  
  it "is not a seventh" do
    @chord.should_not be_seventh
  end
  
  it "is a flat nine" do
    @chord.should be_flat_nine
  end
  
  it 'inspects as "C7b9"' do
    @chord.inspect.should == "C7b9"
  end  
end

describe "C7+9" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,10,15])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "major"
  
  it "is not minor" do
    @chord.should_not be_minor
  end
  
  it "is not a seventh" do
    @chord.should_not be_seventh
  end
  
  it "is a sharp nine" do
    @chord.should be_sharp_nine
  end
  
  it 'inspects as "C7+9"' do
    @chord.inspect.should == "C7+9"
  end  
end

describe Chord do
  describe "#transposed_intervals" do
    before(:each) do
      @chord = Chord.new(:d, [0,8])
    end
  
    it "transposes the intervals based on the root" do
      @chord.transposed_intervals.should == [2,10]
    end
    
    it "transposes the intervals based on the root and a given ordinal" do
      @chord.transposed_intervals(1).should == [3,11]
    end
  end
end
