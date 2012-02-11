require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

MenuItem.blueprint do
	# Attributes here
end

# Blocks
Block.blueprint do
	name { "Random Block" }
end

# Contemporary Issues
ContemporaryIssue.blueprint do
end

# Content Fragments
ContentFragment.blueprint do
	title { "test content fragment" }
	url { "/some/other/url" }
end

# Pages
Page.blueprint do
	title { "test page" }
	url { "/some/url" }
	body { "Lorem ipsum..." }
end

Page.blueprint(:no_slash) do
	url { "no/initial/slash" }
end

# Story
Story.blueprint do
	title { "test story" }
	body { "Lorem ipsum..." }
end

# Person Types
PersonType.blueprint do
end

# Prism Types
PrismType.blueprint do
end

# Role Types
RoleType.blueprint do
end

# Thoughts
Thought.blueprint do
end

# Users
User.blueprint do
	email { "test@test.com" }
	password { "password" }
	roles { "user" }
end

User.blueprint(:admin) do
	roles { "admin" }
end

User.blueprint(:speaker) do
	roles { "speaker" }
end

Chapter.blueprint do
	name { "test chapter" }
end

Location.blueprint do
	name { Faker::Address.city }
	address { Faker::Address.street_address }
	# Attributes here
end

Event.blueprint do
	type { "Social Event" }
	title { "Event Title" }
end

References.blueprint do
  # Attributes here
end
