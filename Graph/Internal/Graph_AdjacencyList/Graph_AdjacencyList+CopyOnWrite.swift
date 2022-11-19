extension Graph_AdjacencyList {
  @discardableResult
  mutating func _update(
    withVertices vertices:
      (first: Vertex?, second: Vertex?) = (nil, nil)
  ) -> (first: Vertex?, second: Vertex?) {
    guard !isKnownUniquelyReferenced(&_storage) else {
      return (nil, nil)
    }
    var firstVertexCopy: Vertex?
    var secondVertexCopy: Vertex?
    var newAdjacencies: [_Vertex: [Edge]] = [:]
    var reference: [_Vertex: _Vertex] = [:]
    
    for vertex in _storage._adjacencies.keys {
      let newVertex = _Vertex(value: vertex._value)
      reference[vertex] = newVertex
      
      if let firstVertex = vertices.first?._storage {
        if firstVertex === vertex {
          firstVertexCopy = Vertex(newVertex)
        }
      }
      if let secondVertex = vertices.second?._storage {
        if secondVertex === vertex {
          secondVertexCopy = Vertex(newVertex)
        }
      }
    }
    
    for (vertex, edges) in _storage._adjacencies {
      var newEdges: [Edge] = []
      for edge in edges {
        let sourceVertex = edge.sourceVertex._storage
        let destinationVertex = edge.destinationVertex._storage
        let newEdge = Edge(
          sourceVertex: Vertex(reference[sourceVertex]!),
          destinationVertex: Vertex(reference[destinationVertex]!),
          weight: edge.weight
        )
        newEdges.append(newEdge)
      }
      let newVertex = reference[vertex]!
      newAdjacencies[newVertex] = newEdges
    }
    _storage = _Storage(adjacencies: newAdjacencies)
    return (firstVertexCopy, secondVertexCopy)
  }
}
