
describe "ContentFragment" do

	it "should strip initial / from url" do
		cf = ContentFragment.make
		cf.url.should eq('test')
	end

end

