extension Graph_AdjacencyList {
  public struct Vertex: Equatable, Hashable {
    weak var _storage: _Vertex?
    
    init(_ vertex: _Vertex) {
      _storage = vertex
    }
    
    var storage: _Vertex {
      guard let storage = _storage else {
        preconditionFailure()
      }
      return storage
    }
    
    public var value: Element {
      get { storage._value }
      set { storage._value = newValue }
    }
  }
}
