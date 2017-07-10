class Tree
  attr_accessor :children, :node_name

  def initialize(name, children=[])
    @children = children
    @node_name = name
  end

  def self.from_hash(hash)
    Tree.new(hash.keys[0], hash[hash.keys[0]].collect {|k, v| Tree.from_hash({k => v}) }.to_a)
  end

  def visit_all(&block)
    visit(&block)
    children.each {|c| c.visit_all(&block) }
  end

  def visit(&block)
    block.call self
  end
end

a = Tree.from_hash({'grandpa' => { 'dad' => {'child1' => {}, 'child2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } } })
a.visit_all {|x| puts x.node_name }
