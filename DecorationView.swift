extension UICollectionView {
    var offsetContentInset: CGFloat {
        return (self.contentInset.left + self.contentInset.right)/2.0
    }
}


class DecorationView: UICollectionReusableView {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print("Kaushal", #function)
        self.backgroundColor = .white
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        print("Kaushal", #function)
    }
}

class CollectionViewLayout: UICollectionViewFlowLayout {
    
    var offsetSectionInset: CGFloat {
        return (self.sectionInset.left + self.sectionInset.right)/2.0
    }
    
    static let kind = "DecorationView"
    static let separatorKinds = [CollectionViewLayout.kind]
    
    var decorationViews = [Int:UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        defer {
            super.prepare()
        }
        guard let collectionView = collectionView else {
            return
        }
        self.minimumLineSpacing = 1/UIScreen.main.scale
        self.minimumInteritemSpacing = self.minimumLineSpacing
        self.decorationViews = [:]
        self.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        let width = collectionView.bounds.insetBy(dx: collectionView.offsetContentInset + self.offsetSectionInset, dy: 0).width
        self.estimatedItemSize = .init(width: width, height: 90.0)
        self.itemSize = UICollectionViewFlowLayout.automaticSize
        self.headerReferenceSize = .init(width: 200, height: 44.0)
        self.register(DecorationView.self, forDecorationViewOfKind:  CollectionViewLayout.kind)
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes: UICollectionViewLayoutAttributes = {
            if let attributes = self.decorationViews[indexPath.section] {
                return attributes
            }
            let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: CollectionViewLayout.kind, with: indexPath)
            self.decorationViews[indexPath.section] = attributes
            return attributes
        }()
        var rect = CGRect.zero
        if let point = self.layoutAttributesForItem(at: IndexPath(row: 0, section: indexPath.section))?.frame.origin {
            rect.origin = point
        }
        if let point = self.layoutAttributesForItem(at: IndexPath(row: 0, section: indexPath.section))?.frame.origin {
            rect.origin = point
        }
        if let rows = self.collectionView?.numberOfItems(inSection: indexPath.section), let frame = self.layoutAttributesForItem(at: IndexPath(row: rows - 1, section: indexPath.section))?.frame {
            rect.size = .init(width: frame.maxX - rect.origin.x, height: frame.maxY - rect.origin.y)
        }
        attributes.frame = rect
        attributes.zIndex = -1
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            guard let baseLayoutAttributes = super.layoutAttributesForElements(in: rect) else {
                return nil
            }
            
            var layoutAttributes = baseLayoutAttributes
            baseLayoutAttributes.filter { $0.representedElementCategory == .cell }.forEach {(layoutAttribute) in
                
                layoutAttributes += CollectionViewLayout.separatorKinds.compactMap({ layoutAttributesForDecorationView(ofKind: $0, at: layoutAttribute.indexPath) })
            }
            
            return layoutAttributes
    }
}

class CollectionViewCell: UICollectionViewCell {
    let nameLabel: UILabel = .init(frame: .zero)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard self.nameLabel.superview == nil else {
            return
        }
        self.nameLabel.numberOfLines = 0
        self.backgroundColor = .lightGray
        self.addSubview(self.nameLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.nameLabel.frame = self.contentView.bounds.insetBy(dx: 15, dy: 15)
    }
}

class ViewController: UIViewController {
    
    let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: CollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.register(CollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        self.view.backgroundColor = .blue
        self.view.addSubview(self.collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewLayoutMarginsDidChange()
        self.collectionView.frame = self.view.bounds
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.nameLabel.text = "Section:\(indexPath.section + 1) Row:\(indexPath.row + 1) "
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! CollectionViewCell
        cell.nameLabel.text = "Header \(indexPath.section + 1)"
        return cell
    }
}
