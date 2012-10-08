module ApplicationHelper

	def parse_references(text)
		text.gsub(ContentFragment.encyclical_reference_regex) { |s|
			id = Encyclical.reference_map[$1]
			"<a class='encyclical_reference_link' href='/social_encyclicals/#{id}#chapter_#{$2}'>(#{$1}, #{$2})</a>"
		}
	end

	def remove_thumbnail_tag(f, page)
		if page.thumbnail_file_name?
			return f.input :delete_thumbnail, :as => :boolean, :label => "Remove thumbnail?"
		end
	end

	def remove_image_tag(f, page)
		if page.image_file_name?
			return f.input :delete_image, :as => :boolean, :label => "Remove image?"
		end
	end

	def remove_homepage_image_tag(f, page)
		if page.homepage_image_file_name?
			return f.input :delete_homepage_image, :as => :boolean, :label => "Remove homepage image?"
		end
	end

	def render_parent_breadcrumb(menu_item)
		output = ""
		parent = menu_item.parent
		if parent && parent.parent_id
			output += render_parent_breadcrumb(parent)
		end
		output += link_to parent.name, parent.url
		output += "<span class='breadcrumb_seperator'>&gt;</span>";
		return output.html_safe
	end

	def pluralize_without_count(count, singular, plural = nil)
		((count == 1 || count =~ / ^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
	end

	def content_fragment_type_map
		ContentFragment.types.map { |t| [content_fragment_type_mapper(t), t] }.sort { |a,b| a[0] <=> b[0] }
	end

	def content_fragment_type_mapper(type)
		type = "Article" if type == "Thought"
		type = "News" if type == "Story"
		type.underscore.humanize.titlecase
	end

	def object_url(object)
		if object.class == Page
			return object.url
		end

		if object.class == Block
			return '/'
		end

		polymorphic_path(object)
	end

	def is_admin?(&block)
		if block_given?
			yield if current_user && current_user.has_role?("admin")
		else
			if current_user && current_user.has_role?("admin")
				return true
			else
				return false
			end
		end
	end

	def is_speaker?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("speaker") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("speaker") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end

	def is_thought_creator?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("thought_creator") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end

	def is_user?(&block)
		if block_given?
			yield if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("admin"))
		else
			if current_user && (current_user.has_role?("user") || current_user.has_role?("speaker") || current_user.has_role?("admin"))
				return true
			else
				return false
			end
		end
	end

	def has_role?(r, &block)
		if block_given?
			yield if current_user && current_user.has_role?(r)
		else
			if current_user && current_user.has_role?(r)
				return true
			else
				return false
			end
		end
	end

	def table(collection, headers, options = {}, &proc)
		options.reverse_merge!({
			:placeholder  => 'No results found',
			:caption      => nil,
			:summary      => nil,
			:footer       => ''
		})
		placeholder_unless collection.any?, options[:placeholder] do
			summary = options[:summary] || "A list of #{collection.first.class.to_s.pluralize}"
			output = "<table summary=\"#{summary}\" class=\"data_table\">\n".html_safe
			output << content_tag('caption', options[:caption]) if options[:caption]
			output << "\t<caption>#{options[:caption]}</caption>\n" if options[:caption]
			output << content_tag('thead', content_tag('tr', headers.collect { |h| "\n\t".html_safe + content_tag('th', h).html_safe }.join("").html_safe).html_safe).html_safe
			output << "<tfoot><tr>".html_safe + content_tag('th', options[:footer], :colspan => headers.size) + "</tr></tfoot>\n".html_safe if options[:footer]
			output << "<tbody>\n".html_safe
			concat(output)
			collection.each do |row|
				proc.call(row, cycle('odd', 'even'))
			end
			concat("</tbody>\n</table>\n".html_safe)
		end
	end

	def placeholder(message = 'No results found', options = {}, &proc)
		# set default options
		o = { :class => 'placeholder', :tag => 'p' }.merge(options)

		# wrap the results of the supplied block, or
		# just print out the message
		if proc
			t = o.delete(:tag)
			concat tag(t, o, true)
			yield
			concat "</#{t}>"
		else
			content_tag o.delete(:tag), message, o
		end
	end

	def placeholder_unless(condition, *args, &proc)
		condition ? proc.call : concat(placeholder(args))
	end

	def content_fragment_edit_url(content_fragment)
		self.send("edit_admin_#{content_fragment.type.to_s.underscore}_url", content_fragment)
	end

	def top_nav_active_link_to(name, url, options = {})
		path = request.path
		logger.info "path = #{request.path} url = #{url}"
		if path.starts_with?(url)
			options[:class] = "#{options[:class]} active"
		end
		link_to name, url, options
	end

	def active_link_to(name, url, options = {})
		path = request.path
		testurl = url.split("?")[0]
		if path == testurl
			options[:class] = "#{options[:class]} active"
		end
		link_to name, url, options
	end
end
