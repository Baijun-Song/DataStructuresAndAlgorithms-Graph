import Queue

extension Graph where Vertex: Hashable {
  // TODO: - Better name for this as well as AVLTree inOrderTraverse
  public func breadthFirstTraverse(
    from startVertex: Vertex
  ) -> [Vertex] {
    var result: [Vertex] = []
    var waiting = DoubleStackQueue<Vertex>()
    var visited = Set<Vertex>()
    waiting.enqueue(startVertex)
    
    while let vertex = waiting.dequeue() {
      visited.insert(vertex)
      result.append(vertex)
      for edge in edges(from: vertex) {
        if !visited.contains(edge.destinationVertex) {
          waiting.enqueue(edge.destinationVertex)
        }
      }
    }
    return result
  }
  
  // TODO: - Recursion VS Stack
//  public func depthFirstTraverse_(
//    from startVertex: Vertex
//  ) -> [Vertex] {
//    var result: [Vertex] = []
//    var waiting = Stack<Vertex>()
//    var visited = Set<Vertex>()
//    waiting.push(startVertex)
//
//    while let vertex = waiting.pop() {
//      visited.insert(vertex)
//      result.append(vertex)
//      for edge in edges(from: vertex) {
//        if !visited.contains(edge.destinationVertex) {
//          waiting.push(edge.destinationVertex)
//        }
//      }
//    }
//    return result
//  }
  
  public func depthFirstTraverse(
    from startVertex: Vertex
  ) -> [Vertex] {
    var result: [Vertex] = []
    var visited = Set<Vertex>()
    _depthFirstTraverse(
      from: startVertex,
      visited: &visited,
      result: &result
    )
    return result
  }
  
  private func _depthFirstTraverse(
    from sourceVertex: Vertex,
    visited: inout Set<Vertex>,
    result: inout [Vertex]
  ) {
    visited.insert(sourceVertex)
    result.append(sourceVertex)
    for edge in edges(from: sourceVertex) {
      if !visited.contains(edge.destinationVertex) {
        _depthFirstTraverse(
          from: edge.destinationVertex,
          visited: &visited,
          result: &result
        )
      }
    }
  }
}
