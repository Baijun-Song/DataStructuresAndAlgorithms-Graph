extension Graph {
  @inlinable
  func _depthFirstTraverse(
    from vertex: Vertex<Element>,
    visitedVertices: inout Set<Vertex<Element>>,
    result: inout [Vertex<Element>]
  ) {
    visitedVertices.insert(vertex)
    result.append(vertex)
    for (adjacentVertex, _) in adjacencies(of: vertex) {
      if !visitedVertices.contains(adjacentVertex) {
        _depthFirstTraverse(
          from: adjacentVertex,
          visitedVertices: &visitedVertices,
          result: &result
        )
      }
    }
  }
}
