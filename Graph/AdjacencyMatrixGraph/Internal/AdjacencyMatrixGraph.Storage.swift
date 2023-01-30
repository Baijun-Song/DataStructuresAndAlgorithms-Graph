extension AdjacencyMatrixGraph {
  @usableFromInline
  final class Storage {
    @usableFromInline
    var indexByNode: [Node<Element>: Int]
    
    @usableFromInline
    var connections: [[ConnectionState]]
    
    @inlinable @inline(__always)
    init(
      indexByNode: [Node<Element>: Int],
      connections: [[ConnectionState]]
    ) {
      self.indexByNode = indexByNode
      self.connections = connections
    }
  }
}
