class Block < ContentFragment
	validates :name, :presence => true
  def self.display(name)
    block = Block.find_by_name(name)
    return "block not found '#{name}'" unless block
    block.body.html_safe
  end
end
