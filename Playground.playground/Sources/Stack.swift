import Foundation

open class Stack<T> {
    private var items: [T]
    
    public init() {
        self.items = []
    }
    
    open func push(element: T) {
        self.items.append(element)
    }
    
    open func pop() -> T? {
        let index = self.values.count - 1
        guard index > -1 else {
            return nil
        }
        return self.items.remove(at: index)
    }
    
    open var values: [T] {
        return self.items
    }
    
    open var count: Int {
        return self.items.count
    }
}
