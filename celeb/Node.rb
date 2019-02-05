class Node
  attr_accessor :outgoing, :incoming, :id
  @@id = -1

  def initialize(outgoing = [], incoming = [])
    @outgoing = outgoing
    @incoming = incoming
    @@id += 1
    @id = @@id
    uniquify
  end

  def add_incoming(node)
    @incoming << node
    node.outgoing << self
    node.uniquify
    self.uniquify
  end

  def add_outgoing(node)
    @outgoing << node
    node.incoming << self
    node.uniquify
    self.uniquify
  end

  def uniquify
    @outgoing = @outgoing.uniq
    @incoming = @incoming.uniq
  end

  def ==(node)
    self.id == node.id
  end

  def ==(id)
    self.id == id
  end

  def to_s
    """
    Node #{@id}
    Outgoing => {#{@outgoing.map { |n| n.id }.join(',')}}
    Incoming => {#{@incoming.map { |n| n.id }.join(',')}}
    """
  end

  def self.reset
    @@id = -1
  end
end