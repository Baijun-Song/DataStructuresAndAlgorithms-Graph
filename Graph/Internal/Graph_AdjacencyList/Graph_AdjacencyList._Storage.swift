extension Graph_AdjacencyList {
  final class _Storage {
    var _adjacencies: [_Vertex: [Edge]]
    
    init(adjacencies: [_Vertex : [Edge]]) {
      self._adjacencies = adjacencies
    }
  }
}
