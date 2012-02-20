class MenuItem < ActiveRecord::Base
	belongs_to :parent, :class_name => 'MenuItem'
	has_many :children, :class_name => 'MenuItem', :foreign_key => 'parent_id', :order => :weight

	def self.menus
		[ "Top", "About" ]
	end

	validates :menu, :inclusion => { :in => MenuItem.menus }
end
