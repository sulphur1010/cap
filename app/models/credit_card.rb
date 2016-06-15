class CreditCard
    extend ActiveSupport::Concern
    include ActiveModel::AttributeMethods
    include ActiveModel::Validations
    include ActiveModel::Conversion

    included do
      extend ActiveModel::Naming
      extend ActiveModel::Translation
    end

    def initialize(attributes={})
      assign_attributes(attributes) if attributes

      super()
    end

    def persisted?
      false
    end
   
	attr_accessor :type, :number, :expire_month, :expire_year, :first_name, :last_name, :cvv2
	
	def assign_attributes(hash)
	end
	
	def self.model_name
		ActiveModel::Name.new(CreditCard)
	end
	
	def to_key
		nil
	end
end
