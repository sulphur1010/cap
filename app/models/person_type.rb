class PersonType < ContentFragment
  has_and_belongs_to_many :content_fragments
end
