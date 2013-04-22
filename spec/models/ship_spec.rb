require 'spec_helper'

describe Ship do
  let(:ship) { build(:ship) }
  
  it { should validate_presence_of :board }
  
  it { should belong_to :board }
  it { should have_many :cells }
  
  it "should be valid" do
    ship.should be_valid
  end
end
