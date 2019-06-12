import Foundation

open class VehicleData<Value> {
    public let value: Value
    public let date: Date
    
    public init(value: Value) {
        self.value = value
        self.date = Date()
    }
}
