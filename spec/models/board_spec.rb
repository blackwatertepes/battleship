require 'spec_helper'

describe Board do
  let(:board) { build(:board) }
  let(:ship_count) { 7 }
  let(:ships) { [] }
  
  it { should validate_presence_of :cells }
  it { should validate_presence_of :rows }
  it { should validate_presence_of :game }
  it { should validate_presence_of :user }
  
  it { should belong_to :game }
  it { should belong_to :user }
  it { should have_many :ships }
  it { should have_many :salvos }
  
  it "should be valid" do
    board.should be_valid
  end
  
  context "when ships are added" do
    before(:each) do
      ship_count.times do
        ship = build(:ship)
        ships << ship
        board.add_ship!(ship)
      end
    end
    
    it "should contain ships" do
      board.fleet.length.should == ship_count
    end
    
    it "should contain all floating ships" do
      board.floating.length.should == ship_count
    end
    
    it "should contain no sunk ships" do
      board.sunk.length.should == 0
    end
    
    it "should not be clear" do
      board.clear?.should be_false
    end
    
    it "should return sets of ship spaces" do
      board.ships.each do |ship|
        board.spaces_by_ship(ship).length.should > 0
      end
    end
    
    it "should return shiped spaces" do
      spaces = ships.inject(0) {|sum, ship| sum + ship.length }
      board.shiped_spaces.length.should == spaces
    end
  end
  
  context "when salvos are added" do

    it "should change the amount of hit spaces" do
      expect{ board.fire!(0, 0) }
      .to change{ board.unhit.length }.by(-1)
    end
  
    it "should mark the space as hit" do
      target = board.targets.sample
      expect{ board.fire!(target.row, target.cell) }
      .to change{ target.hit? }.from(false).to(true)
    end
    
    context "where a ship exists" do
      before(:each) do
        @target = comp.positive_targets.sample
        @ship = comp[@target.row][@target.cell].ship
      end
  
      xit "should injure the ship" do
        expect{ game.fire!(@target.row, @target.cell) }
        .to change{ @ship.injured? }.from(false).to(true)
      end
  
      xit "should add another hit to the ship" do
        expect{ game.fire!(@target.row, @target.cell) }
        .to change{ @ship.hits }.by(1)
      end
  
      xit "should register a sunk ship" do
        expect{ comp.spaces_by_ship(comp.ships.first).each { |space| game.fire!(space.row, space.cell) } }
        .to change{ comp.sunk.length }.by(1)
      end
  
      xit "should register a winner" do
        expect{ comp.shiped_spaces.each { |space| game.fire!(space.row, space.cell) } }
        .to change{ game.winner_user? }.from(false).to(true)
      end
  
      xit "should target the hit ship" do
        game.fire!(@target.row, @target.cell)
        comp.targets.length.should <= 4
      end
    end
    
    context "were a ship does not exist" do
      xit "should register a miss" do
        target = comp.negative_targets.sample
        game.fire!(target.row, target.cell)
        target.hit?.should be_true
        target.ship?.should_not be_true
      end
    
      xit "should return a fire from the comp" do
        expect { game.fire!(rand(10), rand(10)) }
        .to change{ game.board_user.hits.length }.by(1)
      end
    
      xit "should return a win from the comp" do
        expect { 10.times {|a| 10.times {|b| game.fire!(a, b) } } }
        .to change{ game.winner_comp? }.from(false).to(true)
      end
    end
  end
end
