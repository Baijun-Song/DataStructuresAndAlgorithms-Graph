public protocol Graph {
  associatedtype Element
  associatedtype Vertex: Equatable
  typealias Edge = GraphEdge<Vertex>
  
  init(vertices: [Vertex])
  
  var vertices: [Vertex] { get }
  
  @discardableResult
  mutating func makeVertex(value: Element) -> Vertex
  
  mutating func addDirectedEdge(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex,
    weight: Double?
  )
  
  func edges(from sourceVertex: Vertex) -> [Edge]
  
  func weight(
    from sourceVertex: Vertex,
    to destinationVertex: Vertex
  ) -> Double?
}
