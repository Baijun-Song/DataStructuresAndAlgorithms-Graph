extension Graph_AdjacencyMatrix {
  @discardableResult
  mutating func _update(
    withVertices vertices:
      (first: Vertex?, second: Vertex?) = (nil, nil)
  ) -> (first: Vertex?, second: Vertex?) {
    // TODO: - How to copy-on-write without creating identifier
    guard !isKnownUniquelyReferenced(&_storage) else {
      return (nil, nil)
    }
    var firstVertexCopy: Vertex?
    var secondVertexCopy: Vertex?
    var newVertices: [_Vertex] = []
    
    for vertex in _storage._vertices {
      let newVertex =
        _Vertex(value: vertex._value, index: vertex._index)
      newVertices.append(newVertex)
      
      if let firstVertex = vertices.first?.storage {
        if firstVertex === vertex {
          firstVertexCopy = Vertex(newVertex)
        }
      }
      if let secondVertex = vertices.second?.storage {
        if secondVertex === vertex {
          secondVertexCopy = Vertex(newVertex)
        }
      }
    }
    _storage = _Storage(
      vertices: newVertices,
      weights: _storage._weights
    )
    return (firstVertexCopy, secondVertexCopy)
  }
}
