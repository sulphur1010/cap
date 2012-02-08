
describe User do
	
	it "should be valid" do
		u = User.make
		u.should be_valid
	end

end
