require 'spec_helper'

describe Salvo do
  let(:salvo) { build(:salvo) }
  
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }
  it { should validate_presence_of :board }
  
  it { should belong_to :board }
  
  it "should be valid" do
    salvo.should be_valid
  end
end
