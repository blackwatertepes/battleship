require 'spec_helper'

describe Board do
  let(:board) { build(:board) }
  
  it { should validate_presence_of :width }
  it { should validate_presence_of :height }
  
  it "should be valid" do
    board.should be_valid
  end
end
