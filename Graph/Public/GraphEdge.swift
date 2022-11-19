public struct GraphEdge<Vertex: Equatable> {
  let sourceVertex: Vertex
  let destinationVertex: Vertex
  let weight: Double?
}
