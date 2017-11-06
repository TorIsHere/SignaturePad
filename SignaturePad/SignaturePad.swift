//
//  SignaturePad.swift
//  SignaturePad
//
//  Created by Kittikorn Ariyasuk on 23/10/2560 BE.
//  Copyright © 2560 Kittikorn Ariyasuk. All rights reserved.
//

import UIKit

@objc
public protocol SignaturePadDelegate: class {
    func didStart()
    func didFinish()
    @available(*, unavailable, renamed: "didFinish()")
    func startedDrawing()
    @available(*, unavailable, renamed: "didFinish()")
    func finishedDrawing()
}

@objc
@IBDesignable open class SignaturePad: UIView {
    
    private var path: UIBezierPath = UIBezierPath()
    private var dot: UIBezierPath = UIBezierPath()
    private var incrementalImage: UIImage?
    private var points: [CGPoint] = [CGPoint](repeating: CGPoint(), count: 5)
    private var ctr: Int = 0
    
    @IBInspectable private var strokeColor: UIColor = UIColor.black
    @IBInspectable private var bgColor: UIColor = UIColor.white
    @IBInspectable private var lineWidth: CGFloat = 3.0
    
    weak open var delegate: SignaturePadDelegate?
    
    open var isSigned: Bool {
        get {
            guard let _ = incrementalImage else {
                return false
            }
            return true
        }
    }
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        // Drawing code
        incrementalImage?.draw(in: rect)
        path.stroke()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isMultipleTouchEnabled = false
        self.backgroundColor = self.bgColor
        path = UIBezierPath()
        path.lineWidth = lineWidth
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isMultipleTouchEnabled = false
        self.backgroundColor = self.bgColor
        path = UIBezierPath()
        path.lineWidth = lineWidth
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            ctr = 0
            points[0] = touch.location(in: self)
        }
        if let delegate = delegate {
            delegate.didStart()
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point: CGPoint = touch.location(in: self)
            ctr += 1
            points[ctr] = point
            if (ctr == 4) {
                points[3] = CGPoint(x: (points[2].x + points[4].x)/2.0, y: (points[2].y + points[4].y)/2.0)
                path.move(to: points[0])
                path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
                self.setNeedsDisplay()
                
                points[0] = points[3]
                points[1] = points[4]
                ctr = 1
            }
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if ctr < 4 {
            switch ctr {
            case 0:
                dot = UIBezierPath(ovalIn: CGRect(x: points[0].x, y: points[0].y, width: lineWidth, height: lineWidth))
                break
            case 1:
                dot = UIBezierPath(ovalIn: CGRect(x: points[0].x, y: points[0].y, width: lineWidth, height: lineWidth))
                points[0] = points[1]
                break
            case 2:
                dot = UIBezierPath(ovalIn: CGRect(x: points[0].x, y: points[0].y, width: lineWidth, height: lineWidth))
                points[0] = points[2]
                break
            case 3:
                path.move(to: points[0])
                path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2])
                points[0] = points[3]
                break
            default:
                break
            }
        } else {
            points[0] = path.currentPoint
        }
        
        self.drawBitmap()
        self.setNeedsDisplay()
        path.removeAllPoints()
        dot.removeAllPoints()
        ctr = 0
        
        if let delegate = delegate {
            delegate.didFinish()
        }
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
    
    func drawBitmap() -> Void {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0.0)
        UIColor.black.setStroke()
        if incrementalImage == nil {
            let rectPath = UIBezierPath(rect: self.bounds)
            UIColor.white.setFill()
            rectPath.fill()
        }
        incrementalImage?.draw(at: CGPoint.zero)
        path.stroke()
        dot.fill()
        incrementalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    open func clear() -> Void {
        incrementalImage = nil
        dot = UIBezierPath()
        path = UIBezierPath()
        path.lineWidth = lineWidth
        self.setNeedsDisplay()
    }
    
    open func getSignature() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let signature = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signature
    }
}
