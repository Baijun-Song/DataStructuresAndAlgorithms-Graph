public struct Graph_AdjacencyMatrix<Element> {
  var _storage = _Storage(vertices: [], weights: [])
  
  public init() {}
  
  public init(vertices: [Vertex]) {
    for (index, vertex) in vertices.enumerated() {
      _storage._vertices.append(_Vertex(
        value: vertex.value,
        index: index
      ))
    }
    for _ in 0..<vertices.count {
      let newRow: [Double?] =
        .init(repeating: Double.infinity, count: vertices.count)
      _storage._weights.append(newRow)
    }
  }
}

extension Graph_AdjacencyMatrix: Graph {
  public var vertices: [Vertex] {
    _storage._vertices.map { Vertex($0) }
  }
  
  public mutating func makeVertex(value: Element) -> Vertex {
    _update()
    let vertex = _Vertex(
      value: value, index:
        _storage._vertices.count
    )
    _storage._vertices.append(vertex)
    for row in 0..<_storage._weights.count {
      _storage._weights[row].append(Double.infinity)
    }
    let newRow: [Double?] = .init(
      repeating: Double.infinity,
      count: _storage._vertices.count
    )
    _storage._weights.append(newRow)
    _checkInvariants()
    return Vertex(vertex)
  }
  
  public mutating func addDirectedEdge(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex,
    weight: Double?
  ) {
    let verticesCopy =
      _update(withVertices: (sourceVertex, destinationVertex))
    let sourceCopy = verticesCopy.first ?? sourceVertex
    let destinationCopy = verticesCopy.second ?? destinationVertex
    
    let sourceIndex = sourceCopy.storage._index
    let destinationIndex = destinationCopy.storage._index
    precondition(sourceIndex < _storage._vertices.count)
    precondition(destinationIndex < _storage._vertices.count)
    _storage._weights[sourceIndex][destinationIndex] = weight
    _checkInvariants()
  }
  
  public func edges(from sourceVertex: Vertex) -> [Edge] {
    let sourceIndex = sourceVertex.storage._index
    precondition(sourceIndex < _storage._vertices.count)
    var result: [Edge] = []
    
    for column in 0..<_storage._vertices.count {
      let weight = _storage._weights[sourceIndex][column]
      if let weight = weight, weight == Double.infinity {
        continue
      } else {
        let edge = Edge(
          sourceVertex: sourceVertex,
          destinationVertex: Vertex(_storage._vertices[column]),
          weight: weight
        )
        result.append(edge)
      }
    }
    return result
  }
  
  public func weight(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex
  ) -> Double? {
    let sourceIndex = sourceVertex.storage._index
    let destinationIndex = destinationVertex.storage._index
    precondition(sourceIndex < _storage._vertices.count)
    precondition(destinationIndex < _storage._vertices.count)
    let weight = _storage._weights[sourceIndex][destinationIndex]
    precondition((weight ?? 0.0) != Double.infinity)
    return weight
  }
}
