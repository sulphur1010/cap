require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

MenuItem.blueprint do
	name { "menu #{sn}" }
	menu { MenuItem.menus.first }
	weight { 1 }
	parent { nil }
	url { "/page1" }
end

Block.blueprint do
	name { "Random Block" }
end

ContemporaryIssue.blueprint do
end

ContentFragment.blueprint do
	title { "test content fragment" }
	url { "/some/other/url" }
	published { true }
end

Page.blueprint do
	title { "test page" }
	url { "/some/url" }
	body { "Lorem ipsum..." }
end

Page.blueprint(:no_slash) do
	url { "no/initial/slash" }
end

Story.blueprint do
	title { "test story" }
	body { "Lorem ipsum..." }
	category { Story.categories.first }
end

PersonType.blueprint do
end

PrismType.blueprint do
end

Principle.blueprint do
end

Encyclical.blueprint do
	name { "test_#{sn}" }
	body { "test body text here" }
end

RoleType.blueprint do
end

Thought.blueprint do
	user { User.make! }
end

User.blueprint do
	email { "test_#{sn}@test.com" }
	password { "password" }
	password_confirmation { "password" }
	roles { "user" }
end

User.blueprint(:admin) do
	roles { "admin" }
end

User.blueprint(:speaker) do
	roles { "speaker" }
end

User.blueprint(:thought_creator) do
	roles { "thought_creator" }
end

Chapter.blueprint do
	name { "test chapter" }
end

Location.blueprint do
	name { Faker::Address.city }
	address { Faker::Address.street_address }
end

Event.blueprint do
	type { Event.types.first }
	title { "Event Title" }
	event_region { Event.event_regions.first }
end

Event.blueprint(:with_attendees) do
	attendees { [User.make!, User.make!] }
end

EncyclicalReference.blueprint do
end

EmailAddress.blueprint do
  # Attributes here
end
