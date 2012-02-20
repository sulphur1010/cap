class ThoughtsController < ApplicationController

	respond_to :html

	def index
		if request.xhr?
			@thoughts = Thought.where(:published => true).order(:published_at)
			if params[:contemporary_issue]
				ids = params[:contemporary_issue].split(/,/)
				if ids.count > 0
					ciws = []
					ids.each do |id|
						ciws << "contemporary_issues_thoughts.contemporary_issue_id = #{id}"
					end
					@thoughts = @thoughts.joins("JOIN contemporary_issues_thoughts ON contemporary_issues_thoughts.thought_id = thoughts.id").where(ciws.join(" OR "))
				end
			end
			if params[:person_type]
				ids = params[:person_type].split(/,/)
				if ids.count > 0
					ptws = []
					ids.each do |id|
						ptws << "thoughts_person_types.person_type_id = #{id}"
					end
					@thoughts = @thoughts.joins("JOIN thoughts_person_types ON thoughts_person_types.thought_id = thoughts.id").where(ptws.join(" OR "))
				end
			end
			@thoughts = @thoughts.uniq
			render :action => 'ajax_list', :layout => false
			return
		end
		respond_with(@thoughts = Thought.where(:published => true).order(:published_at))
	end

	def show
		@thought = Thought.find(params[:id])
		unless @thought.published
			not_found
		else
			respond_with(@thought)
		end
	end
end
