require 'spec_helper'

CONTROLLERS = [
	:contemporary_issues,
	:encylicals,
	:events,
	:locations,
	:pages,
	:person_types,
	:principles,
	:prism_types,
	:role_types,
	:stories,
	:thoughts
]

ADMIN_CONTROLLERS = [
	:blocks,
	:chapters,
	:contemporary_issues,
	:encyclicals,
	:events,
	:locations,
	:menu_items,
	:pages,
	:person_types,
	:principles,
	:prism_types,
	:role_types,
	:stories,
	:thoughts,
	:users
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

GUEST_SHOULD_PASS = [
	[:contemporary_issues, :show],
	[:thoughts, :show],
	[:role_types, :show],
	[:prism_types, :show],
	[:person_types, :show],
	[:locations, :show],
	[:events, :show],
	[:principles, :show],
	[:stories, :show],
	[:encyclicals, :show],
	[:events, :index],
	[:thoughts, :index],
	[:stories, :index]
]

USER_SHOULD_PASS = GUEST_SHOULD_PASS + []
SPEAKER_SHOULD_PASS = USER_SHOULD_PASS + []
THOUGHT_CREATOR_SHOULD_PASS = [
	[:thoughts, :index],
	[:thoughts, :new],
	[:thoughts, :create],
	[:thoughts, :destroy]
]

describe "Authentication Requests" do
	
	describe "authenticated admin" do
		ADMIN_CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should have access to admin #{c}:#{a}" do
					u = User.make!(:admin)
					sign_in(u)
					send("test_admin_#{a}",c)
					send("success_#{a}")
				end
			end
		end
	end

	describe "guest" do
		GUEST_SHOULD_PASS.each do |c, a|
			it "should have access to #{c}:#{a}" do
				u = User.make!
				sign_in(u)
				send("test_#{a}",c)
				send("success_#{a}")
			end
		end

		ADMIN_CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should NOT have access to admin #{c}:#{a}" do
					u = User.make!
					sign_in(u)
					send("test_admin_#{a}",c)
					send("failure_#{a}")
				end
			end
		end
	end

	describe "authenticated speaker" do
		ADMIN_CONTROLLERS.each do |c|
			ACTIONS.each do |a|
				it "should NOT have access to admin #{c}:#{a}" do
					u = User.make!(:speaker)
					sign_in(u)
					send("test_admin_#{a}",c)
					send("failure_#{a}")
				end
			end
		end
	end

	describe "authenticated thought creator" do
		GUEST_SHOULD_PASS.each do |c, a|
			it "should have access to #{c}:#{a}" do
				u = User.make!
				sign_in(u)
				send("test_#{a}",c)
				send("success_#{a}")
			end
		end

		THOUGHT_CREATOR_SHOULD_PASS.each do |c, a|
			it "should have access to admin #{c}:#{a}" do
				u = User.make!(:thought_creator)
				sign_in(u)
				send("test_admin_#{a}",c)
				send("success_#{a}")
			end
		end
		
		it "should NOT have access to edit another user's thought" do
			u = User.make!(:thought_creator)
			sign_in(u)
			ou = User.make!(:email => 'someotheremail@test.com')
			t = Thought.make
			t.user = ou
			t.save!
			get url_for([:edit, :admin, t])
			assert_response :missing
		end

		it "should have access to edit own thoughts" do
			u = User.make!(:thought_creator)
			sign_in(u)
			t = Thought.make!(:user_id => u.id)
			get url_for([:edit, :admin, t])
			assert_response :success
		end

		it "should NOT have access to update another user's thought" do
			u = User.make!(:thought_creator)
			sign_in(u)
			ou = User.make!(:email => 'someotheremail@test.com')
			t = Thought.make
			t.user = ou
			t.save!
			t.updated_at = t.updated_at + 3.hours
			put url_for([:admin, t]), t.class.to_s.downcase.to_sym => t.attributes
			assert_response :missing
		end

		it "should have access to update own thoughts" do
			u = User.make!(:thought_creator)
			sign_in(u)
			t = Thought.make!(:user_id => u.id)
			t.updated_at = t.updated_at + 3.hours
			put url_for([:admin, t]), t.class.to_s.downcase.to_sym => t.attributes
			assert_response 302
		end

	end

	describe "guest" do
		GUEST_SHOULD_PASS.each do |c, a|
			it "should #{GUEST_SHOULD_PASS.include?([c,a]) ? '' : 'NOT '}have access to #{c}:#{a}" do
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
