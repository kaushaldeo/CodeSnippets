import Foundation

open class BinaryTree<Value> {
    public private(set) var left: BinaryTree<Value>?
    public private(set) var right: BinaryTree<Value>?
    public let value: Value
    
    public required init(value: Value, left: BinaryTree<Value>? = nil, right: BinaryTree<Value>? = nil) {
        self.left = left
        self.right = right
        self.value = value
    }
    
    func update(left: BinaryTree<Value>) {
        self.left = left
    }
    
    func update(right: BinaryTree<Value>) {
        self.right = right
    }
    
}

