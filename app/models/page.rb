class Page < ContentFragment
  validates :url, :presence => true, :uniqueness => true
end
