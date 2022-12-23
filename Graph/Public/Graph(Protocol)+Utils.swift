extension Graph {
  @inlinable @inline(__always)
  public mutating func addUndirectedEdge(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex,
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
}

extension Graph where Vertex: Hashable {
  public func numberOfPaths(
    from source: Vertex,
    to destination: Vertex
  ) -> Int {
    var result = 0
    var visited = Set<Vertex>()
    _numberOfPaths(
      from: source,
      to: destination,
      visited: &visited,
      result: &result
    )
    return result
  }
  
  private func _numberOfPaths(
    from source: Vertex,
    to destination: Vertex,
    visited: inout Set<Vertex>,
    result: inout Int
  ) {
    visited.insert(source)
    if source == destination {
      result += 1
    } else {
      for edge in edges(from: source) {
        if !visited.contains(edge.destinationVertex) {
          _numberOfPaths(
            from: edge.destinationVertex,
            to: destination,
            visited: &visited,
            result: &result
          )
        }
      }
    }
    visited.remove(source)
  }
  
  public var isAllVerticesConnected: Bool {
    let vertices = vertices
    // TODO: - What if empty? true or false
    guard let startVertex = vertices.first else {
      return true
    }
    let visited = Set(breadthFirstTraverse(from: startVertex))
    var result = true
    for vertex in vertices {
      if !visited.contains(vertex) {
        result = false
      }
    }
    return result
  }
  
  public func hasCycle(from startVertex: Vertex) -> Bool {
    var visited = Set<Vertex>()
    return _hasCycle(from: startVertex, visited: &visited)
  }
  
  private func _hasCycle(
    from sourceVertex: Vertex,
    visited: inout Set<Vertex>
  ) -> Bool {
    visited.insert(sourceVertex)
    for edge in edges(from: sourceVertex) {
      if visited.contains(edge.destinationVertex) {
        return true
      } else {
        if _hasCycle(from: edge.destinationVertex, visited: &visited) {
          return true
        }
      }
    }
    visited.remove(sourceVertex)
    return false
  }
}

