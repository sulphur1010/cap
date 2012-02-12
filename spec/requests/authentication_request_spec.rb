require 'spec_helper'

CONTROLLERS = [
	:blocks,
	:contemporary_issues,
	:events,
	:locations,
	:menu_items,
	:pages,
	:person_types,
	:prism_types,
	:role_types,
	:thoughts
]

ACTIONS = [
	:index,
	:show,
	:new,
	:create,
	:edit,
	:update,
	:destroy
]

ADMIN_SHOULD_FAIL = [
	[:blocks, :show],
	[:menu_items, :show],
	[:pages, :show]
]

GUEST_SHOULD_PASS = [
	[:contemporary_issues, :show],
	[:thoughts, :show],
	[:role_types, :show],
	[:prism_types, :show],
	[:person_types, :show],
	[:locations, :show],
	[:events, :show]
]

USER_SHOULD_PASS = GUEST_SHOULD_PASS + []
SPEAKER_SHOULD_PASS = USER_SHOULD_PASS + []

describe "Authentication Requests" do
	
	describe "authenticated admin" do
		CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should have access to #{c}:#{a}" do
					u = User.make!(:admin)
					sign_in(u)
					send("test_#{a}",c)
					if ADMIN_SHOULD_FAIL.include?([c,a])
						send("failure_#{a}")
					else
						send("success_#{a}")
					end
				end
			end
		end
	end

	describe "authenticated speaker" do
		CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should have access to #{c}:#{a}" do
					u = User.make!(:speaker)
					sign_in(u)
					send("test_#{a}",c)
					if SPEAKER_SHOULD_PASS.include?([c,a])
						send("success_#{a}")
					else
						send("failure_#{a}")
					end
				end
			end
		end
	end

	describe "authenticated user" do
		CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should have access to #{c}:#{a}" do
					u = User.make!
					sign_in(u)
					send("test_#{a}",c)
					if USER_SHOULD_PASS.include?([c,a])
						send("success_#{a}")
					else
						send("failure_#{a}")
					end
				end
			end
		end
	end

	describe "guest" do
		CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should have access to #{c}:#{a}" do
					send("test_#{a}", c)
					if GUEST_SHOULD_PASS.include?([c,a])
						send("success_#{a}")
					else
						send("failure_#{a}")
					end
				end
			end
		end
	end

end
