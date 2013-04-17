require 'spec_helper'

describe Game do
  let(:game) { build(:game) }
  let(:user) { game.board_user }
  let(:comp) { game.board_comp }

  it { should validate_presence_of :user }

  it { should belong_to :user }

  it "should be valid" do
    game.should be_valid
  end

  it "should contain 7 boats in each board" do
    user.floating.length.should eq 7
    comp.floating.length.should eq 7
  end

  it "should contain 0 sunk ships in each board" do
    user.sunk.length.should eq 0
    comp.sunk.length.should eq 0
  end

  it "should have no winner" do
    game.winner_user?.should eq false
    game.winner_comp?.should eq false
  end

  it "should return 7 sets of ship spaces" do
    ship = comp.ships.sample
    (1..5).should include comp.spaces_by_ship(ship).length
  end

  it "should return 7 ships for each user" do
    comp.ships.length.should eq 7
  end

  it "should return 18 shiped spaces" do
    comp.shiped_spaces.length.should eq 18
  end

  context "when a user fires" do

    context "and hits" do

      it "should register a hit" do
        row, cell = comp.positive_targets.sample
        game.fire!(row, cell)
        ship = comp[row][cell].ship
        ship.body.should include 1
      end

      it "should register a sunk ship" do
        expect{ comp.spaces_by_ship(comp.ships.first).each { |space| game.fire!(space.row, space.cell) } }
        .to change{ comp.sunk.length }.by(1)
      end

      it "should register a winner" do
        expect{ comp.shiped_spaces.each { |space| game.fire!(space.row, space.cell) } }
        .to change{ game.winner_user? }.from(false).to(true)
      end
    end

    context "and misses" do

      it "should register a miss" do
        row, cell = comp.negative_targets.sample
        game.fire!(row, cell)
        comp[row][cell].hit?.should be_true
        comp[row][cell].ship?.should_not be_true
      end
    end

    it "should return a fire from the comp" do
      expect { game.fire!(rand(10), rand(10)) }
      .to change{ game.board_user.hits.length }.by(1)
    end

    it "should return a win from the comp" do
      expect { 10.times {|a| 10.times {|b| game.fire!(a, b) } } }
      .to change{ game.winner_comp? }.from(false).to(true)
    end
  end
end
