class ThoughtsController < ApplicationController

	respond_to :html

	def index
		if request.xhr?
			@thoughts = Thought.has_body.published.order("published_at desc")
			if params[:contemporary_issue]
				ids = params[:contemporary_issue].split(/,/)
				if ids.count > 0
					ciws = []
					ids.each do |id|
						ciws << "contemporary_issues_content_fragments.contemporary_issue_id = #{id}"
					end
					@thoughts = @thoughts.joins("JOIN contemporary_issues_content_fragments ON contemporary_issues_content_fragments.content_fragment_id = content_fragments.id").where(ciws.join(" OR "))
				end
			end
			if params[:person_type]
				ids = params[:person_type].split(/,/)
				if ids.count > 0
					ptws = []
					ids.each do |id|
						ptws << "content_fragments_person_types.person_type_id = #{id}"
					end
					@thoughts = @thoughts.joins("JOIN content_fragments_person_types ON content_fragments_person_types.content_fragment_id = content_fragments.id").where(ptws.join(" OR "))
				end
			end
			@thoughts = @thoughts.uniq
			@thoughts = @thoughts.sort_by(&:published_at).reverse
			render :action => 'ajax_list', :layout => false
			return
		end
		respond_with(@thoughts = Thought.published.has_body.order("published_at desc"))
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
