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
    let(:bow) { Bow.new(2) }

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

  end

end
