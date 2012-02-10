require 'spec_helper'

describe "Menu Item requests" do
	describe "GET unauthenticated /menu_items" do
		it "should return a 404" do
			get "/menu_items"
			assert_response :missing
		end
	end

	describe "Admin GET authenticated /menu_items" do
		it "should return a valid page" do
			u = User.make!(:admin)
			sign_in(u)
			get "/menu_items"
			assert_response :success
		end
	end

	describe "User GET authenticated /menu_items" do
		it "should return a 404" do
			u = User.make!
			sign_in(u)
			get "/menu_items"
			assert_response :missing
		end
	end
end
