//
//  RoundButton.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 13/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit


@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var bordereColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordereColor.cgColor
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            return self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            return self.layer.borderWidth = borderWidth
        }
    }
}



@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var bordereColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordereColor.cgColor
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            return self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            return self.layer.borderWidth = borderWidth
        }
    }
    
}


@IBDesignable
class RoundedLabel: UILabel {
    
    @IBInspectable var bordereColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = bordereColor.cgColor
        }
    }
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            return self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            return self.layer.borderWidth = borderWidth
        }
    }
    
}


