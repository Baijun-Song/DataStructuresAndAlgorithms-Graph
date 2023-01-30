extension AdjacencyMatrixGraph {
  @usableFromInline
  enum ConnectionState {
    case disconnected
    case connected(weight: Double?)
  }
}
