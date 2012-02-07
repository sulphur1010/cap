require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

ContentFragment.blueprint do
	title { "Test ContentFragment" }
	body { "Some body." }
	url { "/test/content/fragment" }
	published { true }
end

