extension AdjacencyMatrixGraph: CustomStringConvertible {
  public var description: String {
    let s1 = "Adjacency Matrix Graph:\n"
    let s2 = String(repeating: "-", count: 40) + "\n"
    let s3 = "Vertices:\n"
    let s4 = "Connections:\n"
    let s5 = "\n" + String(repeating: "-", count: 40)
    
    let verticesDescription = storage.indexByNode
      .map { (node, index) in
        "(\(index)): \(node.value)"
      }
      .joined(separator: "\n")
    
    let weightsDescription = storage.connections.map { row in
      row.map { connection in
        switch connection {
        case let .connected(weight):
          if let weight = weight {
            return String(format: "%.1f", weight)
          } else {
            return "???"
          }
        case .disconnected:
          return "ø"
        }
      }
    }
    
    let maxWeightDescription = weightsDescription
      .flatMap { $0 }
      .map { $0.count }
      .max() ?? 0
    let columnWidth = maxWeightDescription + 2
    
    let a1 = String(repeating: " ", count: 5)
    let a2 = storage.indexByNode
      .map { (node, index) in
        "(\(index))".padding(
          toLength: columnWidth,
          withPad: " ",
          startingAt: 0
        )
      }
      .joined()
    let firstRowDescription = a1 + a2 + "\n\n"
    
    let flatWeightsDescription = weightsDescription
      .enumerated()
      .map { (index, rowDescription) in
        let b1 = "(\(index))".padding(
          toLength: 5,
          withPad: " ",
          startingAt: 0
        )
        let b2 = rowDescription.map { weightDescription in
          weightDescription.padding(
            toLength: columnWidth,
            withPad: " ",
            startingAt: 0
          )
        }
        return b1 + b2.joined()
      }
      .joined(separator: "\n\n")
    
    return s1 + s2 + s3 + verticesDescription + "\n\n" + s4 +
      firstRowDescription + flatWeightsDescription + s5
  }
}
