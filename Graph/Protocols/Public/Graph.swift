public protocol Graph {
  associatedtype Element
  
  typealias Adjacency = (vertex: Vertex<Element>, weight: Double?)
  
  typealias Path = (vertices: [Vertex<Element>], totalWeight: Double)
  
  typealias SpanningTree = (graph: Self, totalWeight: Double)
  
  init()
    
  var vertices: [Vertex<Element>] { get }
  
  mutating func addVertex(value: Element) -> Vertex<Element>
  
  mutating func addDirectedEdge(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>,
    weight: Double?
  )
  
  func adjacencies(
    of vertex: Vertex<Element>
  ) -> [Adjacency]
  
  func weight(
    from sourceVertex: Vertex<Element>,
    to destinationVertex: Vertex<Element>
  ) -> Double?
}
