require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Page.blueprint do
	title { "test page" }
	url { "/some/url" }
end

Page.blueprint(:no_slash) do
	url { "no/initial/slash" }
end
