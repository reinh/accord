require File.dirname(__FILE__) + '/spec_helper'

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

describe "C Major" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "major"

  it 'inspects as "C"' do
    @chord.inspect.should == "C"
  end
end

describe "C Minor" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7])
  end

  it_should_behave_like "C root"
  it_should_behave_like "minor"
  
  it 'inspects as "Cm"' do
    @chord.inspect.should == "Cm"
  end
end

describe "C diminished" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,6])
  end

  it_should_behave_like "C root"

  it "is diminished" do
    @chord.should be_diminished
  end
  
  it 'inspects as "Cdim"' do
    @chord.inspect.should == "Cdim"
  end
end

describe "C augmented" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,8])
  end

  it_should_behave_like "C root"
  
  it "is augmented" do
    @chord.should be_augmented
  end
  
  it 'inspects as "Caug"' do
    @chord.inspect.should == "Caug"
  end
end

describe "seventh", :shared => true do
  it "has a seventh" do
    @chord.should be_seventh
  end
end

describe "C minor seventh" do
  before(:each) do
    @chord = Chord.new(:c, [0,3,7,10])
  end
  
  it_should_behave_like "C root"
  it_should_behave_like "minor"
  it_should_behave_like "seventh"

  it "has a minor seventh" do
    @chord.should be_minor_seventh
  end
end

describe "C dominant seventh" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,10])
  end

  it_should_behave_like "C root"
  it_should_behave_like "major"
  it_should_behave_like "seventh"
  
  it "has a dominant seventh" do
    @chord.should be_dominant_seventh
  end
end

describe "C major seventh" do
  before(:each) do
    @chord = Chord.new(:c, [0,4,7,11])
  end

  it_should_behave_like "C root"
  it_should_behave_like "major"
  
  it "has a major seventh" do
    @chord.should be_major_seventh
  end
end
