import Queue

extension Graph {
  @inlinable @inline(__always)
  public mutating func addUndirectedEdge(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>,
    weight: Double?
  ) {
    addDirectedEdge(
      from: sourceVertex,
      to: destinationVertex,
      weight: weight
    )
    addDirectedEdge(
      from: destinationVertex,
      to: sourceVertex,
      weight: weight
    )
  }

  @inlinable @inline(__always)
  public func numberOfPaths(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>
  ) -> Int {
    var result = 0
    var visitedVertices = Set<Vertex<Element>>()
    _numberOfPaths(
      from: sourceVertex,
      to: destinationVertex,
      visitedVertices: &visitedVertices,
      result: &result
    )
    return result
  }

  @inlinable
  public var hasIsolatedVertex: Bool {
    let vertices = vertices
    guard let vertex = vertices.first else {
      return false
    }
    let visitedVertices = breadthFirstTraversedVertices(from: vertex)
    return Set(vertices) != Set(visitedVertices)
  }

  @inlinable @inline(__always)
  public func hasCycle(from vertex: Vertex<Element>) -> Bool {
    var visitedVertices = Set<Vertex<Element>>()
    return _hasCycle(
      from: vertex,
      visitedVertices: &visitedVertices
    )
  }
  
  @inlinable
  public func breadthFirstTraversedVertices(
    from vertex: Vertex<Element>
  ) -> [Vertex<Element>] {
    var result: [Vertex<Element>] = []
    var waitingVertices = DoubleStackQueue<Vertex<Element>>()
    var visitedVertices = Set<Vertex<Element>>()
    waitingVertices.enqueue(vertex)

    while let vertex = waitingVertices.dequeue() {
      visitedVertices.insert(vertex)
      result.append(vertex)
      for (adjacentVertex, _) in adjacencies(of: vertex) {
        if !visitedVertices.contains(adjacentVertex) {
          waitingVertices.enqueue(adjacentVertex)
        }
      }
    }
    return result
  }

  @inlinable @inline(__always)
  public func depthFirstTraversedVertices(
    from vertex: Vertex<Element>
  ) -> [Vertex<Element>] {
    var result: [Vertex<Element>] = []
    var visitedVertices = Set<Vertex<Element>>()
    _depthFirstTraverse(
      from: vertex,
      visitedVertices: &visitedVertices,
      result: &result
    )
    return result
  }
}


