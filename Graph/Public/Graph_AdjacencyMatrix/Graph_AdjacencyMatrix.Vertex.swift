extension Graph_AdjacencyMatrix {
  public struct Vertex: Equatable {
    private weak var __weakVertexReference: _Vertex?
    
    init(_ vertex: _Vertex) {
      __weakVertexReference = vertex
    }
    
    var _storage: _Vertex {
      guard let validVertex = __weakVertexReference else {
        preconditionFailure()
      }
      return validVertex
    }
    
    public var value: Element {
      get { _storage._value }
      set { _storage._value = newValue }
    }
  }
}
