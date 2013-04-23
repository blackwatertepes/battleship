require 'spec_helper'

describe Cell do
  let(:cell) { build(:cell) }
  
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :ship }
  
  it { should belong_to :ship }
  
  it "should be valid" do
    cell.should be_valid
  end
  
  it "should not be hit" do
    cell.hit?.should be_false
  end
  
  context "when hit" do
    before(:each) do
      cell.hit!
    end
    
    it "should be hit" do
      cell.hit?.should be_true
    end
  end
end
