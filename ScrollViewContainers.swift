import UIKit
import Foundation

extension UICollectionView {
    func dequeueReusableCell<T: ViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}

extension UITableView {
    func dequeueReusableCell<T: ViewCell>(type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as! T
    }
}

protocol ViewCell {
    static var identifier : String { get }
}
