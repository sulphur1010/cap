class Admin::QuestionsController < ApplicationController
	
	before_filter :require_admin!

	respond_to :html
	
	def index
		respond_with(@questions = Question.order(:body))
	end

	def new
		@question = Question.new
		if params[:id]
			@question.content_fragment = ContentFragment.find(params[:id])
		end
		respond_with(@question)
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

	def destroy
		respond_with(@Question = Question.delete(params[:id]), :location => admin_questions_url)
	end

	def type
		@eq = params[:eq]
		if params[:eq]!= ""
			@questions ||= Array.new
			@questions2 = Question.find(:all, :include => [:content_fragment], :order => 'content_fragments.type')
			@questions2.each do |question|
				if question.body.downcase.match("\\b"+@eq.downcase+"\\b")
					@questions.push(question)
				end
			end
		else
			@questions = Question.find(:all, :include => [:content_fragment], :order => 'content_fragments.type')
		end
		if !request.xhr?
			render :action => :index
		end
	end
	def title 
		@eq = params[:eq]
		if params[:eq]!= ""
			@questions ||= Array.new
			@questions2 = Question.find(:all, :include => [:content_fragment], :order => 'content_fragments.title')
			@questions2.each do |question|
				if question.body.downcase.match("\\b"+@eq.downcase+"\\b")
					@questions.push(question)
				end
			end
		else
			@questions = Question.find(:all, :include => [:content_fragment], :order => 'content_fragments.title')
		end
		if !request.xhr?
			render :action => :index
		end
	end
	def summary
		@questions = Question.find(:all, :order => 'body')
		@questions = @questions.sort_by{|e| ActionController::Base.helpers.strip_tags((e[:body]))}
		if !request.xhr?
			render :action => :index
		end
	end

	def search
		#@s = params[:eq]
		@eq = params[:eq]
		if params[:eq] && params[:eq] != ""
			sql ="SELECT * FROM questions WHERE body LIKE '%"+params[:eq]+"%'"
			@questions = Question.find_by_sql sql
		else
			@questions = Question.find(:all)
		end
		if !request.xhr?
			render :action => :index
		end
		if request.xhr?
			render :partial => 'teaser', :collection => @questions
			return
		end
	end

end
