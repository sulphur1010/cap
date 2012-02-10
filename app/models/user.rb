class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :title, :phone, :chapter_id

  has_many :content_fragments
	belongs_to :chapter

	after_initialize :load_roles
	before_save :convert_roles
	before_create :add_user_role

	def has_role?(r)
		normalize_roles
		@roles.include?(r) or @roles.include?(r.to_s)
	end

	def roles=(r)
		if r.class == Array
			@roles = r.map { |r| r.to_s }
		else
			@roles = [r.to_s] unless r.to_s.blank?
		end
		normalize_roles
		@roles
	end

	def add_role!(r)
		if r.class == Array
			r.each do |role|
				self.add_role!(role)
			end
		else
			@roles << r.to_s unless r.to_s.blank?
		end
		normalize_roles
		@roles
	end

	def roles
		unless @roles
			@roles = self.role_list.split(/,/).map { |r| r.strip } rescue []
		end
		normalize_roles
		@roles
	end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

	private

	def add_user_role
		@roles = [ "user" ]
	end

	def normalize_roles
		@roles = @roles.map { |r| r.to_s }
	end

	def load_roles
		@roles = self.role_list.split(/,/).map { |r| r.strip } rescue []
		unless @roles
			@roles = []
		end
	end

	def convert_roles
		self.role_list = @roles.map { |r| r.to_s }.join(',')
	end

end
