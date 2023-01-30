import PriorityQueue

extension Graph {
  @inlinable @inline(__always)
  public func shortestPath(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>,
    treatsNoWeightAs: TreatsNoWeightAs = .value(0.0)
  ) -> Path? {
    shortestPaths(from: sourceVertex)[destinationVertex]
  }
  
  public func shortestPaths(
    from vertex: Vertex<Element>,
    treatsNoWeightAs: TreatsNoWeightAs = .value(0.0)
  ) -> [Vertex<Element>: Path] {
    var pathTracker = PathTracker(
      sourceVertex: vertex,
      treatsNoWeightAs: treatsNoWeightAs
    )
    var waitingVertices = MinimumPriorityQueue { a, b in
      let w1 = pathTracker.path(to: a).totalWeight
      let w2 = pathTracker.path(to: b).totalWeight
      return w1 < w2
    }
    waitingVertices.enqueue(vertex)
    
    while let vertex = waitingVertices.dequeue() {
      for (adjacentVertex, weight) in adjacencies(of: vertex) {
        if pathTracker.previousAdjacency(of: adjacentVertex) != nil {
          let newWeight: Double
          if let weight = weight {
            newWeight = weight
          } else {
            switch treatsNoWeightAs {
            case let .value(value):
              newWeight = value
            case .preconditionFailure:
              preconditionFailure()
            }
          }
          let w1 = pathTracker.path(to: vertex).totalWeight
          let w2 = pathTracker.path(to: adjacentVertex).totalWeight
          if w1 + newWeight >= w2 {
            continue
          }
        }
        pathTracker.updatePreviousAdjacency(
          (vertex, weight),
          for: adjacentVertex
        )
        waitingVertices.enqueue(adjacentVertex)
      }
    }
    
    var result: [Vertex<Element>: Path] = [:]
    for vertex in pathTracker.trackedVertices {
      result[vertex] = pathTracker.path(to: vertex)
    }
    return result
  }
}
