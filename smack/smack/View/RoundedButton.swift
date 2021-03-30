//
//  RoundedButton.swift
//  smack
//
//  Created by Juliam Costa on 30/03/2021.
//

import UIKit

//@IBDesignable class MyButton: UIButton
//{
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        updateCornerRadius()
//    }
//
//    @IBInspectable var rounded: Bool = false {
//        didSet {
//            updateCornerRadius()
//        }
//    }
//
//    func updateCornerRadius() {
//        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
//    }
//}

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
}   
