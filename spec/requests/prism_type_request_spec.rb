require 'spec_helper'

describe "Prism Type requests" do
	describe "GET unpublished /prism_type" do
		it "should return a 404" do
			p = PrismType.make!(:published => false)
			get prism_type_path(p)
			assert_response :missing
		end
	end

	describe "GET published /prism_type" do
		it "should return a valid page" do
			p = PrismType.make!
			get prism_type_path(p)
			assert_response :success
		end
	end
end
