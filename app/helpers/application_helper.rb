module ApplicationHelper
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
end
