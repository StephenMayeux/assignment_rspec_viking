require 'viking'

describe "Viking" do

  let(:bow) { Bow.new }
  let(:bow2) { Bow.new(5) }
  let(:bow3) { Bow.new(0) }

  context "Bow Class" do

    it "the arrow count is readable and starts wit 10 by default" do
      expect(bow.arrows).to eq(10)
    end

    it "creates number of arrows with specified argument" do
      expect(bow2.arrows).to eq(5)
    end

    it "reduces number of arrows by 1 when used" do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it "raises error when shooting 0 arrows" do
      expect { bow3.use }.to raise_error(RuntimeError)
    end

  end

  context "Viking Class" do

    let(:viking) { Viking.new("Tanya", 75) }
    let(:viking2) { Viking.new("Stephen", 90) }
    let(:viking3) { Viking.new("Todd", 1) }
    let(:bow) { Bow.new(2) }
    let(:empty_bow) { Bow.new(0) }
    let(:axe) { Axe.new }
    let(:fists) { Fists.new }

    it "sets the name of a Viking" do
      expect(viking.name).to eq("Tanya")
    end

    it "sets the health of a Viking" do
      expect(viking.health).to eq(75)
    end

    it "is impossible to set health after initialization" do
      expect {viking.health = 90}.to raise_error(NoMethodError)
    end

    it "sets weapon to nil by default" do
      expect(viking.weapon).to eq(nil)
    end

    it "sets weapon after picking it up" do
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to eq(bow)
    end

    it "raises error for picking up wrong weapon" do
      expect { viking.pick_up_weapon(Machete.new) }.to raise_error(NameError)
    end

    it "resets a weapon" do
      viking.pick_up_weapon(axe)
      viking.pick_up_weapon(bow)
      expect(viking.weapon).to_not eq(axe)
    end

    it "removes weapon" do
      viking.pick_up_weapon(axe)
      viking.drop_weapon
      expect(viking.weapon).to eq(nil)
    end

    it "reduces health after receiving attack" do
      viking.receive_attack(20)
      expect(viking.health).to eq(55)
    end

    it "reduces health after calling #take_damage" do
      viking.receive_attack(20)
      allow(viking).to receive(:take_damage).with(20)
      expect(viking.health).to eq(55)
    end

    it "attacks another viking and lowers their health" do
      viking.pick_up_weapon(bow)
      viking.attack(viking2)
      expect(viking2.health).to eq(70)
    end

    it "receives #take_damage method" do
      viking.pick_up_weapon(bow)
      viking.attack(viking2)
      allow(viking2).to receive(:take_damage).with(20)
      expect(viking2.health).to be(70)
    end

    it "runs #damage_with_fists if no weapons" do
      viking.attack(viking2)
      allow(viking2).to receive(:damage_with_fists)
    end

    it "attacks with fists multiplier" do
      x = viking.strength * fists.instance_variable_get(:@multiplier)
      y = viking2.health
      viking.attack(viking2)
      expect(viking2.health).to eq(y-x)
    end

    it "runs damage_with_weapon if weapons" do
      viking.pick_up_weapon(bow)
      viking.attack(viking2)
      allow(viking2).to receive(:damage_with_weapon)
    end

    it "attacks with multiplier if weapon" do
      x = viking.strength * bow.instance_variable_get(:@multiplier)
      y = viking2.health
      viking.pick_up_weapon(bow)
      viking.attack(viking2)
      expect(viking2.health).to eq(y-x)
    end

    it "attacking with no bows runs fists" do
      viking.pick_up_weapon(empty_bow)
      viking.attack(viking2)
      allow(viking2).to receive(:damage_with_fists)
    end

    it "death raises an error" do
      viking.pick_up_weapon(bow)
      expect{viking.attack(viking3)}.to raise_error(RuntimeError)
    end

  end

end
