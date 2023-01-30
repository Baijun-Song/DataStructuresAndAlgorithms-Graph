extension AdjacencyListGraph {
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
    var newAdjacenciesByNode: [Node<Element>: [Adjacency]] = [:]
    var newNodeByOldNode: [Node<Element>: Node<Element>] = [:]
    
    for node in storage.adjacenciesByNode.keys {
      let newNode = Node(value: node.value)
      newNodeByOldNode[node] = newNode
      
      if node == firstVertex?.node {
        firstUpdatedVertex = Vertex(node: newNode)
      }
      if node == secondVertex?.node {
        secondUpdatedVertex = Vertex(node: newNode)
      }
    }
    
    for (node, adjacencies) in storage.adjacenciesByNode {
      let newNode = newNodeByOldNode[node]!
      var newAdjacencies: [Adjacency] = []
      for (vertex, weight) in adjacencies {
        let newNode = newNodeByOldNode[vertex.node]!
        newAdjacencies.append((Vertex(node: newNode), weight))
      }
      newAdjacenciesByNode[newNode] = newAdjacencies
    }
    
    storage = Storage(adjacenciesByNode: newAdjacenciesByNode)
    return (firstUpdatedVertex, secondUpdatedVertex)
  }
}
