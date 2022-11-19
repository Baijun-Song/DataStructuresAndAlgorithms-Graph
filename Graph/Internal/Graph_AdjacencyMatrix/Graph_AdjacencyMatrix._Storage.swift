extension Graph_AdjacencyMatrix {
  final class _Storage {
    var _vertices: [_Vertex]
    var _weights: [[Double?]]
    
    init(vertices: [_Vertex], weights: [[Double?]]) {
      self._vertices = vertices
      self._weights = weights
    }
  }
}
