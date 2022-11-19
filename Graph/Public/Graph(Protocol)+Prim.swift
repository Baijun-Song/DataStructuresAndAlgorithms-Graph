import PriorityQueue

extension Graph where Vertex: Hashable {
  public func makeMinimumSpanningTree(
  ) -> (graph: Self, totalWeight: Double) {
    var result: Self = .init(vertices: vertices)
    var totalWeight = 0.0
    var visited = Set<Vertex>()
    var waiting = MinimumPriorityQueue<Edge> { a, b in
      // TODO: - No weight? default to 0.0?
      a.weight ?? 0.0 < b.weight ?? 0.0
    }
    
    guard let startVertex = vertices.first else {
      return (result, totalWeight)
    }
    visited.insert(startVertex)
    for edge in edges(from: startVertex) {
      if !visited.contains(edge.destinationVertex) {
        waiting.enqueue(edge)
      }
    }
    
    while let dequeuedEdge = waiting.dequeue() {
      let vertex = dequeuedEdge.destinationVertex
      guard !visited.contains(vertex) else {
        continue
      }
      visited.insert(vertex)
      totalWeight += dequeuedEdge.weight ?? 0.0
      result.addDirectedEdge(
        from: dequeuedEdge.sourceVertex,
        to: dequeuedEdge.destinationVertex,
        weight: dequeuedEdge.weight
      )
      for edge in edges(from: vertex) {
        if !visited.contains(edge.destinationVertex) {
          waiting.enqueue(edge)
        }
      }
    }
    return (result, totalWeight)
  }
}
