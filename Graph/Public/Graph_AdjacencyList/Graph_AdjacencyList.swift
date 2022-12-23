public struct Graph_AdjacencyList<Element> {
  var _storage = _Storage(adjacencies: [:])
  
  public init() {}
  
  public init(vertices: [Vertex]) {
    for vertex in vertices {
      _storage._adjacencies[_Vertex(value: vertex.value)] = []
    }
  }
}

extension Graph_AdjacencyList: Graph {
  public var vertices: [Vertex] {
    _storage._adjacencies.keys.map { Vertex($0) }
  }
  
  public mutating func makeVertex(value: Element) -> Vertex {
    _update()
    let vertex = _Vertex(value: value)
    _storage._adjacencies[vertex] = []
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
    let edge = Edge(
      sourceVertex: sourceCopy,
      destinationVertex: destinationCopy,
      weight: weight
    )
    let source = sourceCopy.storage
    precondition(_storage._adjacencies.keys.contains(source))
    _storage._adjacencies[source]!.append(edge)
  }
  
  public func edges(from sourceVertex: Vertex) -> [Edge] {
    let source = sourceVertex.storage
    precondition(_storage._adjacencies.keys.contains(source))
    return _storage._adjacencies[source]!
  }
  
  public func weight(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex
  ) -> Double? {
    let edge = edges(from: sourceVertex).first {
      $0.destinationVertex == destinationVertex
    }
    if let edge = edge {
      return edge.weight
    } else {
      preconditionFailure()
    }
  }
}
