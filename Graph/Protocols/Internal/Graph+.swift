extension Graph {
  @usableFromInline
  func _numberOfPaths(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>,
    visitedVertices: inout Set<Vertex<Element>>,
    result: inout Int
  ) {
    visitedVertices.insert(sourceVertex)
    if sourceVertex == destinationVertex {
      result += 1
    } else {
      for (adjacentVertex, _) in adjacencies(of: sourceVertex) {
        if !visitedVertices.contains(adjacentVertex) {
          _numberOfPaths(
            from: adjacentVertex,
            to: destinationVertex,
            visitedVertices: &visitedVertices,
            result: &result
          )
        }
      }
    }
    visitedVertices.remove(sourceVertex)
  }
  
  @usableFromInline
  func _hasCycle(
    from vertex: Vertex<Element>,
    visitedVertices: inout Set<Vertex<Element>>
  ) -> Bool {
    visitedVertices.insert(vertex)
    for (adjacentVertex, _) in adjacencies(of: vertex) {
      if visitedVertices.contains(adjacentVertex) {
        return true
      } else {
        let hasCycle = _hasCycle(
          from: adjacentVertex,
          visitedVertices: &visitedVertices
        )
        if hasCycle {
          return true
        }
      }
    }
    visitedVertices.remove(vertex)
    return false
  }
}
