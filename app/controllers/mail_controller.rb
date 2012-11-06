class MailController < ApplicationController

	before_filter :load_contact_lists

	def index
	end
end
