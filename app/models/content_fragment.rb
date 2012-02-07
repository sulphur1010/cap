class ContentFragment < ActiveRecord::Base
  belongs_to :user

	alias :author :user

  validates :title, :presence => true
  validates :url, :uniqueness => true

end
