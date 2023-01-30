public struct Vertex<Element>: Equatable, Hashable {
  @usableFromInline
  weak var _node: Node<Element>?
  
  @inlinable @inline(__always)
  init(node: Node<Element>) {
    _node = node
  }
  
  @inlinable @inline(__always)
  var node: Node<Element> {
    guard let node = _node else {
      preconditionFailure()
    }
    return node
  }
  
  @inlinable @inline(__always)
  public var value: Element {
    get { node.value }
    set { node.value = newValue }
  }
}
