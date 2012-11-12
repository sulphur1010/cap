class SentEmailMessagesController < ApplicationController

	before_filter :require_admin!
	before_filter :load_contact_lists

	def index
		@sent_email_messages = SentEmailMessage.order("updated_at desc")
	end

	def new
		@sent_email_message = SentEmailMessage.draft.where(:user_id => current_user.id).first
		unless @sent_email_message
			@sent_email_message = SentEmailMessage.new(:user_id => current_user.id)
			@sent_email_message.save
		end
	end

	def update
		@sent_email_message = SentEmailMessage.find(params[:id])
		@sent_email_message.update_attributes(params[:sent_email_message])
		@sent_email_message.queue!

		if request.xhr?
			render :nothing, :status => 200
		else
			redirect_to sent_email_messages_url
		end
	end

end
