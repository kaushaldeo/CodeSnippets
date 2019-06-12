
import Foundation

typealias KDViewCell = String

class DataModel {}

class CountryModel: DataModel {
    let name: String
    let code: String
    let imageURL: String
    
    init(name: String, code: String, imageURL:String) {
        self.name = name
        self.code = code
        self.imageURL = imageURL
    }
}

extension CountryModel: CustomStringConvertible {
    var description: String {
        return """
        <CountryModel>
        <name>\(self.name)</name>
        <code>\(self.code)</code>
        <imageURL>\(self.imageURL)</imageURL>
        </CountryModel>
        """
    }
}

class ViewModel<Value:DataModel> {
    let type: KDViewCell
    let value: Value
    
    init(type: KDViewCell, value: Value) {
        self.type = type
        self.value = value
    }
}

extension ViewModel: CustomStringConvertible {
    var description: String {
        return """
        <ViewModel>
        <type>\(self.type)</type>
        \(self.value)
        </ViewModel>
        """
    }
}

var results = [ViewModel<DataModel>]()

let item = CountryModel(name: "India", code: "IND", imageURL: "")
results.append(ViewModel<DataModel>(type: "Kaushal", value: item))
print(results)
