@usableFromInline
final class Node<Element>: Equatable, Hashable {
  @usableFromInline
  var value: Element
  
  @inlinable @inline(__always)
  init(value: Element) {
    self.value = value
  }
  
  @inlinable @inline(__always)
  static func == (lhs: Node, rhs: Node) -> Bool {
    lhs === rhs
  }
  
  @inlinable @inline(__always)
  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
}
