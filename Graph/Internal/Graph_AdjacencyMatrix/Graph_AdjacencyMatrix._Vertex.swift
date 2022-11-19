extension Graph_AdjacencyMatrix {
  final class _Vertex: _GraphVertexProtocol, Equatable {
    var _value: Element
    let _index: Int
    
    init(value: Element, index: Int) {
      self._value = value
      self._index = index
    }
    
    static func == (
      lhs: _Vertex,
      rhs: _Vertex
    ) -> Bool {
      let leftId = ObjectIdentifier(lhs)
      let rightId = ObjectIdentifier(rhs)
      return leftId == rightId
    }
  }
}
