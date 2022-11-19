extension Graph_AdjacencyList {
  final class _Vertex: _GraphVertexProtocol, Equatable, Hashable {
    var _value: Element
    
    init(value: Element) {
      self._value = value
    }
    
    static func == (
      lhs: _Vertex,
      rhs: _Vertex
    ) -> Bool {
      let leftId = ObjectIdentifier(lhs)
      let rightId = ObjectIdentifier(rhs)
      return leftId == rightId
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(ObjectIdentifier(self))
    }
  }
}

