module ApplicationHelper
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
    self.send("edit_#{content_fragment.type.to_s.underscore}_url", content_fragment)
  end

  def active_link_to(name, url)
    path = request.path
    options = {}
    if url == path
      options[:class] = "active"
    end
    link_to name, url, options
  end
end
