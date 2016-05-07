require 'warmup'

describe "Warmup" do

  let(:warmup) { Warmup.new }

  context "#gets_shout" do

    it "returns an upcase string from input" do
      allow(warmup).to receive(:gets).and_return("florida")
      expect(warmup.gets_shout).to eq("FLORIDA")
    end

  end

  context "#triple_size" do

    it "returns the triple size of something" do
      an_array = double("Array", :size => 3)
      expect(warmup.triple_size(an_array)).to eq(9)
    end

  end

  context "#calls_some_methods" do

    it "string receives #upcase!" do
      a_string = double("String", :upcase! => "TAIWAN")
    end

    it "receives #reverse!" do
      a_string = double("String", :reverse! => "NAWIAT")
    end

    it "returns an entirely new object" do
      a_string = double("String", :upcase! => "TAIWAN", :reverse! => "NAWIAT")
      expect(warmup.calls_some_methods(a_string)).not_to eq(a_string)
    end

  end

end
