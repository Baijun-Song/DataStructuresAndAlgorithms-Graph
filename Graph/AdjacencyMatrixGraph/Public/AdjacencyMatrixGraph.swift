public struct AdjacencyMatrixGraph<Element> {
  @usableFromInline
  var storage = Storage(indexByNode: [:], connections: [])
  
  @inlinable @inline(__always)
  public init() {}
}

extension AdjacencyMatrixGraph: Graph {
  @inlinable @inline(__always)
  public var vertices: [Vertex<Element>] {
    storage.indexByNode.keys.map { Vertex(node: $0) }
  }
  
  @inlinable
  public mutating func addVertex(value: Element) -> Vertex<Element> {
    update()
    let newNode = Node(value: value)
    let newIndex = storage.indexByNode.count
    storage.indexByNode[newNode] = newIndex
    
    for rowIndex in 0..<storage.connections.count {
      storage.connections[rowIndex].append(.disconnected)
    }
    let newRow = Array<ConnectionState>(
      repeating: .disconnected,
      count: storage.indexByNode.count
    )
    storage.connections.append(newRow)
    checkInvariants()
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
    let destinationNode = destinationVertex.node
    guard
      let sourceIndex =
        storage.indexByNode[sourceNode],
      let destinationIndex =
        storage.indexByNode[destinationNode]
    else {
      preconditionFailure()
    }
    precondition(sourceIndex < storage.connections.count)
    precondition(destinationIndex < storage.connections.count)
    storage.connections[sourceIndex][destinationIndex] =
      .connected(weight: weight)
    checkInvariants()
  }
  
  @inlinable
  public func adjacencies(
    of vertex: Vertex<Element>
  ) -> [(vertex: Vertex<Element>, weight: Double?)] {
    guard
      let rowIndex = storage.indexByNode[vertex.node]
    else {
      preconditionFailure()
    }
    precondition(rowIndex < storage.connections.count)
    var result: [Adjacency] = []
    
    for (node, colomuIndex) in storage.indexByNode {
      let connection = storage.connections[rowIndex][colomuIndex]
      switch connection {
      case let .connected(weight):
        result.append((Vertex(node: node), weight))
      case .disconnected:
        break
      }
    }
    return result
  }
  
  @inlinable
  public func weight(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>
  ) -> Double? {
    let sourceNode = sourceVertex.node
    let destinationNode = destinationVertex.node
    guard
      let sourceIndex =
        storage.indexByNode[sourceNode],
      let destinationIndex =
        storage.indexByNode[destinationNode]
    else {
      preconditionFailure()
    }
    precondition(sourceIndex < storage.connections.count)
    precondition(destinationIndex < storage.connections.count)
    
    let connection =
      storage.connections[sourceIndex][destinationIndex]
    switch connection {
    case let .connected(weight):
      return weight
    case .disconnected:
      preconditionFailure()
    }
  }
}
