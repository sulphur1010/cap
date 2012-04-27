class Admin::QuestionsController < ApplicationController
	respond_to :html
	
	def index
		respond_with(@questions = Question.order(:body))
	end

	def new
		respond_with(@question = Question.new)
	end

	def create
		params[:question].delete(:content_fragment_type) if params[:question].has_key?(:content_fragment_type)
		@question = Question.new(params[:question])
		@question.user = current_user
		@question.save!
		respond_with(@question, :location => admin_questions_url)
	end

	def edit
		respond_with(@question = Question.find(params[:id]))
	end

	def update
		params[:question].delete(:content_fragment_type) if params[:question].has_key?(:content_fragment_type)
		respond_with(@question = Question.update(params[:id], params[:question]), :location => admin_questions_url)
	end

end
