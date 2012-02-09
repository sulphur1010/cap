
describe Page do

	it "should be valid" do
		p = Page.make!
		p.should be_valid
	end

	it "should prepend an initial / to url" do
		p = Page.make!(:no_slash)
		p.url.should eq("/no/initial/slash")
	end
end

