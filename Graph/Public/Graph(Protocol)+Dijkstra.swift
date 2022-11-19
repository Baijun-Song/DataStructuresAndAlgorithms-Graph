import PriorityQueue

enum GraphVisitState<Vertex: Equatable> {
  case start
  case edge(GraphEdge<Vertex>)
}

extension Graph where Vertex: Hashable {
  public func shortestPath(
    from startVertex: Vertex,
    to destinationVertex: Vertex
  ) -> [Edge] {
    let paths = paths(from: startVertex)
    return path(to: destinationVertex, with: paths)
  }
  
  public func shortestPaths(
    from startVertex: Vertex
  ) -> [Vertex: [Edge]] {
    var result: [Vertex: [Edge]] = [:]
    let paths = paths(from: startVertex)
    for vertex in paths.keys {
      result[vertex] = path(to: vertex, with: paths)
    }
    return result
  }
}

extension Graph where Vertex: Hashable {
  typealias Paths = [Vertex: GraphVisitState<Vertex>]
  
  func path(
    to destinationVertex: Vertex,
    with paths: Paths
  ) -> [Edge] {
    var vertex = destinationVertex
    var path: [Edge] = []
    while let visitState = paths[vertex] {
      guard case .edge(let edge) = visitState else {
        break
      }
      path = [edge] + path
      vertex = edge.sourceVertex
    }
    return path
  }
  
  func distance(
    to destinationVertex: Vertex,
    with paths: Paths
  ) -> Double {
    let path = path(to: destinationVertex, with: paths)
    // TODO: - If there is no weight? default to 0.0?
    return path.compactMap { $0.weight }.reduce(0.0, +)
  }
  
  func paths(from startVertex: Vertex) -> Paths {
    var paths: Paths = [startVertex: .start]
    var waiting = MinimumPriorityQueue { a, b in
      let d1 = distance(to: a, with: paths)
      let d2 = distance(to: b, with: paths)
      return d1 < d2
    }
    
    while let dequeuedVertex = waiting.dequeue() {
      for edge in edges(from: dequeuedVertex) {
        // TODO: - If there is no weight?
        guard let weight = edge.weight else {
          continue
        }
        if paths[edge.destinationVertex] != nil {
          let d1 = distance(to: dequeuedVertex, with: paths) + weight
          let d2 = distance(to: edge.destinationVertex, with: paths)
          if d1 >= d2 {
            continue
          }
        }
        paths[edge.destinationVertex] = .edge(edge)
        waiting.enqueue(edge.destinationVertex)
      }
    }
    return paths
  }
}
