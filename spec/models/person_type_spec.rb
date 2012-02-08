
describe PersonType do

	it "should be valid" do
		pt = PersonType.make
		pt.should be_valid
	end

end

