require 'spec_helper'

describe Ship do
  let(:ship) { build(:ship) }
  
  it { should validate_presence_of :board }
  
  it { should belong_to :board }
  it { should have_many :cells }
  
  it "should be valid" do
    ship.should be_valid
  end
  
  it "should not be injured" do
    ship.injured?.should be_false
  end
  
  it "should have a name" do
    ship.name.should be
  end
  
  it "should have a length" do
    ship.length.should > 0
  end
  
  it "should have a direction" do
    ship.direction.should be
  end
  
  it "should have a location" do
    ship.x.should >= 0
    ship.y.should >= 0
  end
    
  context "when hit" do
    before(:each) do
      ship.save
      ship.hit!(0)
    end
    
    it "should be injured" do
      ship.injured?.should be_true
    end
    
    it "should be floating if the length is greater than 1" do
      ship = create(:ship, :length => 2)
      ship.hit!(0)
      ship.floating?.should be_true
    end
  end
  
  context "when all cells are hit" do
    before(:each) do
      ship.save
      ship.length.times do |cell|
        ship.hit!(cell)
      end
    end
    
    it "should be sunk" do
      ship.sunk?.should be_true
    end
  end
end
