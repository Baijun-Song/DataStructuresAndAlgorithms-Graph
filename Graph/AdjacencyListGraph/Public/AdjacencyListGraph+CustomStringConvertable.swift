extension AdjacencyListGraph: CustomStringConvertible {
  public var description: String {
    let s1 = "Adjacency List Graph:\n"
    let s2 = String(repeating: "-", count: 40) + "\n\n"
    let s3 = "\n" + String(repeating: "-", count: 40)
    
    var result = ""
    for (node, adjacencies) in storage.adjacenciesByNode {
      let edgeDescription = adjacencies
        .map { "\($0.vertex.value)" }
        .joined(separator: ", ")
      result += "\(node.value) --> [\(edgeDescription)]\n"
    }
    return s1 + s2 + result + s3
  }
}
