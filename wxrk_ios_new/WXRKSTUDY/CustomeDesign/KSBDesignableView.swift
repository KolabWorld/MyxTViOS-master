//
//  KSBDesignableView.swift
//  WXRK $STUDY
//
//  Created by KaramjeetSingh on 29/07/22.
//

import Foundation
import UIKit
@IBDesignable
class KSBDesignableView: UIView {
    @IBInspectable var shadowSpread: CGFloat = 0 {
          didSet {
              if shadowSpread == 0 {
                  layer.shadowPath = nil
              } else {
                  let dx = -shadowSpread
                  let rect = bounds.insetBy(dx: dx, dy: dx)
                  layer.shadowPath = UIBezierPath(rect: rect).cgPath
              }
          }
      }
}

@IBDesignable
class KSBDesignableButton: UIButton {
}

@IBDesignable
class KSBDesignableLabel: UILabel {
}

@IBDesignable
class KSBDesignableTableView: UITableView {
    
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    @IBInspectable var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
            
        }
        set {
            layer.shadowRadius = newValue / 2.0
            
        }
        
    }
    
//    @IBInspectable var shadowSpread: CGFloat = 0 {
//           didSet {
//               if shadowSpread == 0 {
//                   layer.shadowPath = nil
//               } else {
//                   let dx = -shadowSpread
//                   let rect = bounds.insetBy(dx: dx, dy: dx)
//                   layer.shadowPath = UIBezierPath(rect: rect).cgPath
//               }
//           }
//       }
    
    
}

//@IBDesignable class ShadowView: UIView {    @IBInspectable var shadowColor: UIColor? {        get {            if let color = layer.shadowColor {                return UIColor(cgColor: color)            }            return nil        }        set {            if let color = newValue {                layer.shadowColor = color.cgColor            } else {                layer.shadowColor = nil            }        }    }    @IBInspectable var shadowOpacity: Float {        get {            return layer.shadowOpacity        }        set {            layer.shadowOpacity = newValue        }    }    @IBInspectable var shadowOffset: CGPoint {        get {            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)        }        set {            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)        }     }    @IBInspectable var shadowBlur: CGFloat {        get {            return layer.shadowRadius        }        set {            layer.shadowRadius = newValue / 2.0        }    }    @IBInspectable var shadowSpread: CGFloat = 0 {        didSet {            if shadowSpread == 0 {                layer.shadowPath = nil            } else {                let dx = -shadowSpread                let rect = bounds.insetBy(dx: dx, dy: dx)                layer.shadowPath = UIBezierPath(rect: rect).cgPath            }        }    }}
