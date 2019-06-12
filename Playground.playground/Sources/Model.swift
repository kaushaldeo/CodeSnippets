import Foundation

public typealias KDViewCell = String

open class DataModel {}

open class CountryModel: DataModel {
    let name: String
    let code: String
    let imageURL: String
    
    public init(name: String, code: String, imageURL:String) {
        self.name = name
        self.code = code
        self.imageURL = imageURL
    }
}

open class ViewModel<Value:DataModel> {
    public let type: KDViewCell
    public let value: Value
    
    public init(type: KDViewCell, value: Value) {
        self.type = type
        self.value = value
    }
}

