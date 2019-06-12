
import Foundation



enum VehicleDataReason: Error {
    case invalid
}

func divide(_ index:Int) throws -> VehicleData<String> {
    guard index > 0 else {
        throw VehicleDataReason.invalid
    }
    return VehicleData<String>(value:UUID().uuidString.components(separatedBy: "-").reduce("", +).lowercased())
}

let result = Result {
    return try divide(-10)
}
print(result)
switch result {
case .success(let index):
    print(index.date, index.value)
case .failure(let error):
    print(error)
}
