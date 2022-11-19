extension Graph_AdjacencyMatrix {
  func _checkInvariants() {
    assert(_storage._vertices.count == _storage._weights.count)
  }
}
