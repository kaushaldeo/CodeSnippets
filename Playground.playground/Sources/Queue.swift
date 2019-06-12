import Foundation

open class Queue<T> {
    private var items: [T]
    
    public init() {
        self.items = []
    }
    
    open func add(element: T) {
        self.items.append(element)
    }
    
    open func dequeue() -> T? {
        if self.items.count == 0 {
            return nil
        }
        return self.items.remove(at: 0)
    }
    
    open var values: [T] {
        return self.items
    }
    
    open var count: Int {
        return self.items.count
    }
}
