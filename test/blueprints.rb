require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

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
end

Page.blueprint(:no_slash) do
	url { "no/initial/slash" }
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
	password { "testtest" }
end
