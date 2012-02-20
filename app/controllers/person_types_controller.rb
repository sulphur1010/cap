class PersonTypesController < ApplicationController

	respond_to :html

	def show
		@person_type = PersonType.find(params[:id])
		unless @person_type.published
			not_found
		else
			respond_with(@person_type)
		end
	end
end
