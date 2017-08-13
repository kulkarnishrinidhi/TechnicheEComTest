//
//  RoundButton.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 13/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

protocol CircularViewConvertiable: class {
    func circular()
}

extension CircularViewConvertiable where Self: UIView {
    func circular() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}


@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var bordereColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordereColor.cgColor
        }
    }
}

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var cornerrRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerrRadius
        }
    }
    
}


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.masksToBounds = newValue > 0
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        } set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}




