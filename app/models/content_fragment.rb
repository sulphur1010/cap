class ContentFragment < ActiveRecord::Base
  belongs_to :user

	alias :author :user

end
