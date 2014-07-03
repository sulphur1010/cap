class EventsController < ApplicationController

	respond_to :html

	def index
		@events = Event.upcoming
		process_events_search
	end

	def past
		@events = Event.past
		process_events_search
	end

	def show
		@thanks = params.has_key?(:thanks) && params[:thanks] == '1'
		flash[:notice] = 'Thank you for registering for this event.' if @thanks
		session[:return_url] = request.url unless current_user
		@event = Event.find(params[:id])
		sql ="SELECT * FROM events WHERE id IN (SELECT related_event_id FROM relateds_events WHERE event_id="+@event.id.to_s+")"
		@teaser_events = Event.find_by_sql sql
		respond_with(@event)
	end

	def thanks
		@payment_method = params[:payment_method] rescue nil
		respond_with(@event = Event.find(params[:id]))
	end

	def advanced_rsvp
		@event = Event.find(params[:id])

		@payment_method = params[:payment_method]
		@total_price = Event.EVENT_34_PRICE
		@dinners = params[:dinner].to_i
		@guest = params.has_key?("guest")
		@count = 1
		if @guest
			@count = 2
			@total_price += Event.EVENT_34_GUEST_PRICE
		end
		@total_price += (@dinners * Event.EVENT_34_DINNER_PRICE)

		if (@event.spots_left - @count) < 0
			redirect_to event_url(@event), :alert => 'There are no spots available for that event.'
			return
		end

		if @payment_method == "paypal"
			payment_confirmation = PaymentConfirmation.new
			payment_confirmation.event = @event
			if user_signed_in?
				payment_confirmation.user = current_user
			end
			if payment_confirmation.save
				item_name = "#{@event.title} (#{@price_title})"
				invoice_id = payment_confirmation.id

				data = {
					"quanitity_1" => "1",
					"amount_1" => Event.EVENT_34_PRICE,
					"item_name_1" => "Registration Fee",
					"quantity_3" => @dinners,
					"amount_3" => Event.EVENT_34_DINNER_PRICE,
					"item_name_3" => "Dinner Fee"
				}

				if @guest
					data["quantity_2"] = "1"
					data["amount_2"] = Event.EVENT_34_GUEST_PRICE
					data["item_name_2"] = "Guest Registration Fee"
				end

				session[:guest_name] = params[:guest_name]

				redirect_to "#{paypal_url(@event, invoice_id, 0)}&#{data.to_query}"
				return
			else
				redirect_to event_path(@event), :alert => "Error redirecting to paypal for payment."
				return
			end
		else
			@attendee_event = AttendeesEvent.new(params[:attendees_event])
			@attendee_event.event = @event
			@attendee_event.count = @count
			@attendee_event.total_cost = @total_price
			@attendee_event.created_at = Time.now
			@attendee_event.updated_at = Time.now
			@attendee_event.payment_method = @payment_method
			@attendee_event.guest_name = params[:guest_name]
			@attendee_event.dinner_count = @dinners

			if @attendee_event.save
				UserMailer.event_registered_user(@event, @attendee_event).deliver
				UserMailer.event_registered_admin(@event, @attendee_event, nil).deliver
				redirect_to thanks_event_path(@event, :payment_method => @attendee_event.payment_method, :amount => @total_price), :notice => 'You have registered to attend the event.'
			else
				render :action => "show"
			end
		end
	end

	def rsvp
		@event = Event.find(params[:id])

		@payment_method = params[:payment_method]
		@price = params[:price].to_d
		@count = params[:count].to_i
		@total_price = @count * @price
		@price_title = "Standard"

		# VALIDATIONS

		if @event.free_event
			@price = 0
			@total_price = 0
			@payment_method = "other"
		else
			allowed_prices = [@event.cost]
			allowed_prices << @event.discounted_cost if @event.allow_discount
			if !allowed_prices.include?(@price)
				redirect_to event_url(@event), :alert => "Price not acceptible"
				return
			end

			@price_title = @event.discounted_text if @price == @event.discounted_cost
		end

		if !["other", "paypal", "3rd_party"].include?(@payment_method)
			redirect_to event_url(@event), :notice => 'Payment method not acceptible.'
			return
		end

		if (@event.spots_left - @count) < 0
			redirect_to event_url(@event), :alert => 'There are no spots available for that event.'
			return
		end

		#if user_signed_in? && @event.attendees.include?(current_user)
		#	redirect_to event_url(@event), :notice => 'You are already attending that event.'
		#	return
		#end

		other_rsvp_payment if @payment_method == "other"
		paypal_rsvp_payment if @payment_method == "paypal"
		rd_party_rsvp_payment if @payment_method == "3rd_party"
	end

	def unrsvp
		@event = Event.find(params[:id])
		unless user_signed_in?
			session[:return_url] = unrsvp_event_url(@event)
			redirect_to new_user_session_url, :notice => 'You must sign in to unRSVP.'
			return
		end
		if @event.attendees.include?(current_user)
			@event.attendees.delete(current_user)
			redirect_to @event, :notice => 'You have unregistered to attend the event.'
		else
			redirect_to events_url, :alert => 'You are not attending that event.'
		end
	end

	private

	def process_events_search
		if request.xhr?
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
			if params[:event_region]
				types = params[:event_region].split(/,/)
				if types.count > 0
					ews = []
					types.each do |t|
						ews << "event_region = '#{t}'"
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
		render :action => 'index'
	end

	def other_rsvp_payment
		if !@event.free_event && !@event.allow_other_payment_type
			redirect_to event_url(@event), :alert => 'That payment method is not accepted for this event.'
			return
		end
		@attendee_event = AttendeesEvent.new
		if user_signed_in?
			@attendee_event.attendee = current_user
		else
			@attendee_event.email = params[:attendees_event][:email]
			@attendee_event.first_name = params[:attendees_event][:first_name]
			@attendee_event.last_name = params[:attendees_event][:last_name]
		end
		@attendee_event.event = @event
		@attendee_event.count = @count
		@attendee_event.total_cost = @total_price
		@attendee_event.created_at = Time.now
		@attendee_event.updated_at = Time.now

		if @attendee_event.save
			UserMailer.event_registered_user(@event, @attendee_event).deliver
			UserMailer.event_registered_admin(@event, @attendee_event, nil).deliver
			redirect_to @event, :notice => 'You have registered to attend the event.'
		else
			render :action => "show"
		end
	end

	def paypal_rsvp_payment
		if !@event.allow_paypal
			redirect_to event_url(@event), :alert => 'That payment method is not accepted for this event.'
			return
		end

		payment_confirmation = PaymentConfirmation.new
		payment_confirmation.event = @event
		if user_signed_in?
			payment_confirmation.user = current_user
		end
		if payment_confirmation.save
			item_name = "#{@event.title} (#{@price_title})"
			invoice_id = payment_confirmation.id
			redirect_to "#{paypal_url(@event, invoice_id, 0)}&quantity_1=#{@count}&amount_1=#{@price}&item_name_1=" + URI.encode(item_name)
			return
		else
			redirect_to event_path(@event), :alert => "Error redirecting to paypal for payment."
			return
		end
	end

	def rd_party_rsvp_payment
		if !@event.allow_3rd_party_payment
			redirect_to event_url(@event), :alert => 'That payment method is not accepted for this event.'
			return
		end

		redirect_to event_path(@event)
		return
	end
end
