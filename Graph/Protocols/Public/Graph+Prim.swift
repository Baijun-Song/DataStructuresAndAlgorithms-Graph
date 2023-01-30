import PriorityQueue

extension Graph {
  typealias Edge = (
    sourceVertex: Vertex<Element>,
    destinationVertex: Vertex<Element>,
    weight: Double?
  )
  
  public func makeMinimumSpanningTree(
    from vertex: Vertex<Element>? = nil,
    treatsNoWeightAs: TreatsNoWeightAs = .value(0.0)
  ) -> SpanningTree {
    var graph = Self.init()
    var totalWeight = 0.0
    var newVertexByOldVertex: [Vertex<Element>: Vertex<Element>] = [:]
    var visitedVertices = Set<Vertex<Element>>()
    var waitingEdges = MinimumPriorityQueue<Edge> { a, b in
      let defaultWeight: Double
      switch treatsNoWeightAs {
      case let .value(value):
        defaultWeight = value
      case .preconditionFailure:
        preconditionFailure()
      }
      let w1 = a.weight ?? defaultWeight
      let w2 = b.weight ?? defaultWeight
      return w1 < w2
    }
    
    guard let vertex = vertex == nil ? vertices.first : vertex else {
      return (graph, totalWeight)
    }
    update(vertex)
    
    while let edge = waitingEdges.dequeue() {
      guard !visitedVertices.contains(edge.destinationVertex) else {
        continue
      }
      update(edge.destinationVertex)
      graph.addDirectedEdge(
        from: newVertexByOldVertex[edge.sourceVertex]!,
        to: newVertexByOldVertex[edge.destinationVertex]!,
        weight: edge.weight
      )
      
      if let weight = edge.weight {
        totalWeight += weight
      } else {
        switch treatsNoWeightAs {
        case let .value(value):
          totalWeight += value
        case .preconditionFailure:
          preconditionFailure()
        }
      }
    }
    return (graph, totalWeight)
    
    func update(_ vertex: Vertex<Element>) {
      visitedVertices.insert(vertex)
      let newVertex = graph.addVertex(value: vertex.value)
      newVertexByOldVertex[vertex] = newVertex
      for (adjacentVertex, weight) in adjacencies(of: vertex) {
        if !visitedVertices.contains(adjacentVertex) {
          waitingEdges.enqueue((vertex, adjacentVertex, weight))
        }
      }
    }
  }
}
