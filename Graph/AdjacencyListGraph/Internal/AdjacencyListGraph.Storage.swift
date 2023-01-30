extension AdjacencyListGraph {
  @usableFromInline
  final class Storage {
    @usableFromInline
    var adjacenciesByNode: [Node<Element>: [Adjacency]]
    
    @inlinable @inline(__always)
    init(adjacenciesByNode: [Node<Element> : [Adjacency]]) {
      self.adjacenciesByNode = adjacenciesByNode
    }
  }
}
