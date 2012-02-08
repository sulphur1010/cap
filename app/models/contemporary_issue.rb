class ContemporaryIssue < ContentFragment
  has_and_belongs_to_many :content_fragments

  def random_thought
    thoughts = self.content_fragments.where(:type => 'Thought').where(:published => true)
    thoughts[rand(thoughts.count)]
  end

end
