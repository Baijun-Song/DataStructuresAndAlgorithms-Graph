extension AdjacencyMatrixGraph {
  @inlinable @inline(__always)
  mutating func update() {
    _update(withFirstVertex: nil, withSecondVertex: nil)
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withVertex vertex: Vertex<Element>
  ) -> Vertex<Element> {
    let updated =
      _update(withFirstVertex: vertex, withSecondVertex: nil)
    guard let firstVertex = updated.firstVertex else {
      preconditionFailure()
    }
    return firstVertex
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withFirstVertex firstVertex: Vertex<Element>,
    withSecondVertex secondVertex: Vertex<Element>
  ) -> (firstVertex: Vertex<Element>, secondVertex: Vertex<Element>) {
    let updated = _update(
      withFirstVertex: firstVertex,
      withSecondVertex: secondVertex
    )
    guard
      let firstVertex = updated.firstVertex,
      let secondVertex = updated.secondVertex
    else {
      preconditionFailure()
    }
    return (firstVertex, secondVertex)
  }
  
  @usableFromInline
  @discardableResult
  mutating func _update(
    withFirstVertex firstVertex: Vertex<Element>?,
    withSecondVertex secondVertex: Vertex<Element>?
  ) -> (firstVertex: Vertex<Element>?, secondVertex: Vertex<Element>?) {
    guard !isKnownUniquelyReferenced(&storage) else {
      return (firstVertex, secondVertex)
    }
    var firstUpdatedVertex: Vertex<Element>?
    var secondUpdatedVertex: Vertex<Element>?
    var newIndexByNode: [Node<Element>: Int] = [:]
    
    for (node, index) in storage.indexByNode {
      let newNode = Node(value: node.value)
      newIndexByNode[newNode] = index
      
      if node == firstVertex?.node {
        firstUpdatedVertex = Vertex(node: newNode)
      }
      if node == secondVertex?.node {
        secondUpdatedVertex = Vertex(node: newNode)
      }
    }
    
    storage = Storage(
      indexByNode: newIndexByNode,
      connections: storage.connections
    )
    return (firstUpdatedVertex, secondUpdatedVertex)
  }
}
