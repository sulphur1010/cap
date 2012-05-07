class MenuItem < ActiveRecord::Base
	belongs_to :parent, :class_name => 'MenuItem'
	has_many :children, :class_name => 'MenuItem', :foreign_key => 'parent_id', :order => :weight

	def self.menus
		[ "Top", "About" ]
	end

	def self.menu_types
		[ "Normal", "Contemporary Issues" ]
	end

	def self.all_with_relative_depth
		MenuItem.where(:parent_id => nil).order(:weight).all.map { |m| [m, m.all_children] }.flatten
	end

	def all_children
		MenuItem.where(:parent_id => self).order(:weight).map { |m| [m, m.all_children] }.flatten
	end

	def menu_depth
		if self.parent
			self.parent.menu_depth + 1
		else
			0
		end
	end

	def target
		ContentFragment.find_by_url(self.url) rescue nil
	end

	def parent_menu_name_with_depth
		"#{" - " * self.menu_depth}#{self.name}"
	end

end
