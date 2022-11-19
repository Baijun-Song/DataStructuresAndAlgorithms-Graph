extension Graph_AdjacencyList: CustomStringConvertible {
  public var description: String {
    let s1 = "Adjacency-List-based Graph:\n"
    let s2 = String(repeating: "-", count: 40) + "\n\n"
    var result = ""
    let s3 = "\n" + String(repeating: "-", count: 40)
    
    for (vertex, edges) in _storage._adjacencies {
      let edgeDescription = edges
        .map { "\($0.destinationVertex.value)" }
        .joined(separator: ", ")
      result += "\(vertex._value) --> [\(edgeDescription)]\n"
    }
    return s1 + s2 + result + s3
  }
}
