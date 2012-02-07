require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

ContentFragment.blueprint do
	title { "test content fragment" }
	url { "/some/other/url" }
end

Page.blueprint do
	title { "test page" }
	url { "/some/url" }
end

Page.blueprint(:no_slash) do
	url { "no/initial/slash" }
end
