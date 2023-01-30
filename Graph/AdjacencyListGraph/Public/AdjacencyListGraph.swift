public struct AdjacencyListGraph<Element> {
  @usableFromInline
  var storage = Storage(adjacenciesByNode: [:])
  
  @inlinable @inline(__always)
  public init() {}
}

extension AdjacencyListGraph: Graph {
  @inlinable @inline(__always)
  public var vertices: [Vertex<Element>] {
    storage.adjacenciesByNode.keys.map { Vertex(node: $0) }
  }
  
  @inlinable @inline(__always)
  public mutating func addVertex(value: Element) -> Vertex<Element> {
    update()
    let newNode = Node(value: value)
    storage.adjacenciesByNode[newNode] = []
    return Vertex(node: newNode)
  }
  
  @inlinable
  public mutating func addDirectedEdge(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>,
    weight: Double?
  ) {
    precondition(sourceVertex != destinationVertex)
    let (sourceVertex, destinationVertex) = update(
      withFirstVertex: sourceVertex,
      withSecondVertex: destinationVertex
    )
    let sourceNode = sourceVertex.node
    precondition(storage.adjacenciesByNode.keys.contains(sourceNode))
    let newNeighbor = (destinationVertex, weight)
    storage.adjacenciesByNode[sourceNode]!.append(newNeighbor)
  }
  
  @inlinable @inline(__always)
  public func adjacencies(
    of vertex: Vertex<Element>
  ) -> [(vertex: Vertex<Element>, weight: Double?)] {
    let node = vertex.node
    precondition(storage.adjacenciesByNode.keys.contains(node))
    return storage.adjacenciesByNode[node]!
  }
  
  @inlinable
  public func weight(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>
  ) -> Double? {
    let sourceNode = sourceVertex.node
    precondition(storage.adjacenciesByNode.keys.contains(sourceNode))
    let adjacency = storage.adjacenciesByNode[sourceNode]!.first {
      $0.vertex == destinationVertex
    }
    guard let adjacency = adjacency else {
      preconditionFailure()
    }
    return adjacency.weight
  }
}
