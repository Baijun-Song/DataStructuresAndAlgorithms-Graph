struct PathTracker<Element> {
  typealias Path = (vertices: [Vertex<Element>], totalWeight: Double)
  typealias Adjacency = (vertex: Vertex<Element>, weight: Double?)
  
  private var prevAdjacencyByVertex: [Vertex<Element>: Adjacency]
  var treatsNoWeightAs: TreatsNoWeightAs
  
  @inline(__always)
  init(
    sourceVertex: Vertex<Element>,
    treatsNoWeightAs: TreatsNoWeightAs
  ) {
    prevAdjacencyByVertex = [sourceVertex: (sourceVertex, nil)]
    self.treatsNoWeightAs = treatsNoWeightAs
  }
  
  @inline(__always)
  var trackedVertices: [Vertex<Element>] {
    Array(prevAdjacencyByVertex.keys)
  }
  
  func path(to vertex: Vertex<Element>) -> Path {
    var currVertex = vertex
    var vertices: [Vertex<Element>] = [vertex]
    var totalWeight = 0.0
    while let prevAdjacency = prevAdjacencyByVertex[currVertex] {
      let (prevVertex, weight) = prevAdjacency
      guard prevVertex != currVertex else {
        break
      }
      vertices = [prevVertex] + vertices
      if let weight = weight {
        totalWeight += weight
      } else {
        switch treatsNoWeightAs {
        case let .value(value):
          totalWeight += value
        case .preconditionFailure:
          preconditionFailure()
        }
      }
      currVertex = prevVertex
    }
    return (vertices, totalWeight)
  }
  
  @inline(__always)
  mutating func updatePreviousAdjacency(
    _ prevAdjacency: Adjacency,
    for vertex: Vertex<Element>
  ) {
    prevAdjacencyByVertex[vertex] = prevAdjacency
  }
  
  @inline(__always)
  func previousAdjacency(of vertex: Vertex<Element>) -> Adjacency? {
    if let prevAdjacency = prevAdjacencyByVertex[vertex] {
      return prevAdjacency.vertex == vertex ? nil : prevAdjacency
    } else {
      return nil
    }
  }
}
