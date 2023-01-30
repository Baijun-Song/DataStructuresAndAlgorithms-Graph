extension AdjacencyMatrixGraph {
  @inlinable @inline(__always)
  func checkInvariants() {
    assert(storage.indexByNode.count == storage.connections.count)
  }
}
