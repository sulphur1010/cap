class EventsController < ApplicationController

	before_filter :require_admin!, :except => [ :show, :list ]

  respond_to :html

  def index
    respond_with(@events = Event.order(:start_date))
  end

  def list
		if request.xhr?
			@events = Event.order(:start_date)
			if params[:event_type]
				types = params[:event_type].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "type = '#{t}'"
					end
					@events = @events.where(ews.join(" OR "))
				end
			end
			if params[:contemporary_issue]
				ids = params[:contemporary_issue].split(/,/)
				if ids.count > 0
					ciws = []
					ids.each do |id|
						ciws << "contemporary_issues_events.contemporary_issue_id = #{id}"
					end
					@events = @events.joins("JOIN contemporary_issues_events ON contemporary_issues_events.event_id = events.id").where(ciws.join(" OR "))
				end
			end
			if params[:chapter]
				ids = params[:chapter].split(/,/)
				if ids.count > 0
					cws = []
					ids.each do |id|
						cws << "chapter_id = #{id}"
					end
					@events = @events.where(cws.join(" OR "))
				end
			end
			if params[:person_type]
				ids = params[:person_type].split(/,/)
				if ids.count > 0
					ptws = []
					ids.each do |id|
						ptws << "events_person_types.person_type_id = #{id}"
					end
					@events = @events.joins("JOIN events_person_types ON events_person_types.event_id = events.id").where(ptws.join(" OR "))
				end
			end
			@events = @events.uniq
			render :action => 'ajax_list', :layout => false
			return
		end
    respond_with(@events = Event.order(:start_date))
  end

  def show
    respond_with(@event = Event.find(params[:id]))
  end

  def new
    respond_with(@event = Event.new)
  end

  def create
    respond_with(@event = Event.create(params[:event]), :location => events_url)
  end

  def edit
    respond_with(@event = Event.find(params[:id]))
  end

  def update
    respond_with(@event = Event.update(params[:id], params[:event]), :location => events_url)
  end

  def destroy
    respond_with(@event = Event.delete(params[:id]), :location => events_url)
  end

end
