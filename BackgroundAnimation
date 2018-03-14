//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

extension UIColor {
    func darker() -> UIColor {
        var r : CGFloat = 0.0
        var g : CGFloat = 0.0
        var b : CGFloat = 0.0
        var a : CGFloat = 1.0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(red: max(r - 0.2,0), green: max(g - 0.2,0), blue: max(b - 0.2,0), alpha: a)
    }
}

class SquareView: UIView, CAAnimationDelegate {
    
    fileprivate func setup() {
        self.layer.addSublayer(self.sublayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup
    }
    
    let sublayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let strokeWidth = self.bounds.width / 8
        var frame = self.bounds
        frame.size.width -= strokeWidth
        frame.size.height -= strokeWidth
        self.sublayer.path = UIBezierPath(rect: frame).cgPath
    }
    
    var color : UIColor = UIColor.clear {
        willSet {
            self.sublayer.fillColor = newValue.cgColor
            self.backgroundColor = newValue.darker()
        }
    }
    
    func animation(color: UIColor, duration: CFTimeInterval = 1.0) {
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.fillMode = kCAFillModeForwards
        animation.duration = duration
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.fromValue = self.backgroundColor?.cgColor
        animation.toValue = color.darker().cgColor
        animation.delegate = self;
        
        let shapeAnimation = CABasicAnimation()
        shapeAnimation.keyPath = "fillColor"
        shapeAnimation.fillMode = kCAFillModeForwards
        shapeAnimation.duration = duration
        shapeAnimation.repeatCount = 1
        shapeAnimation.autoreverses = false
        shapeAnimation.fromValue = self.sublayer.fillColor
        shapeAnimation.toValue = color.cgColor
        shapeAnimation.delegate = self;
        
        self.layer.add(animation, forKey: "kAnimation")
        self.sublayer.add(shapeAnimation, forKey: "kAnimation")
        self.color = color
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.layer.removeAnimation(forKey: "kAnimation")
        self.sublayer.removeAnimation(forKey: "kAnimation")
    }
}

let view = SquareView(frame: CGRect(x: 10, y: 100, width: 200, height: 300))
view.color = UIColor.blue

PlaygroundPage.current.liveView = view
view.animation(color: UIColor.red)
