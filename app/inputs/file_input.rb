class FileInput < Formtastic::Inputs::FileInput
	def to_html
		val = object.send(method)
		html = ""
		if val.class.to_s == "Paperclip::Attachment"
			html = template.image_tag(val, :class => "paperclip_image")
		end
		html += super
		html.html_safe
	end
end
