//
//  NSTag.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 19/01/21.
//

import UIKit
struct NSTag {
    
    //Mandatory
    var title:String?
    
    //Optionals
    var leftIcon:UIImage?
    var rightIcon:UIImage?
    var leftSelectedIcon:UIImage?
    var rightSelectedIcon:UIImage?
    var textColor:UIColor?
    var textSelectedColor:UIColor?
    var backgroundColor:UIColor?
    var backgroundSelectedColor:UIColor?
    var borderColor:UIColor?
    var borderSelectedColor:UIColor?
    var cornerRadius:CGFloat?
    var font:UIFont?
    var borderWidth:CGFloat?
    var borderSelectedWidth:CGFloat?
    
    var isSelected = false
    var primaryKey = 0
    var enableSelection =  true
    
    // Init
    init(title:String,
         primaryKey:Int = 0,
         isSelected:Bool = false,
         enableSelection:Bool = false,
         leftIcon:UIImage? = nil,rightIcon:UIImage? = nil,
         leftSelectedIcon:UIImage? = nil,rightSelectedIcon:UIImage? = nil,
         textColor:UIColor? = nil,textSelectedColor:UIColor? = nil,
         backgroundColor:UIColor? = nil,backgroundSelectedColor:UIColor? = nil,
         borderColor:UIColor? = nil,borderSelectedColor:UIColor? = nil,
         borderWidth:CGFloat? = nil,borderSelectedWidth:CGFloat? = nil,
         cornerRadius:CGFloat? = nil,
         font:UIFont? = nil) {
        
        self.title = title
        self.isSelected = isSelected
        self.primaryKey = primaryKey
        self.enableSelection = enableSelection
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.leftSelectedIcon = leftSelectedIcon
        self.rightSelectedIcon = rightSelectedIcon
        self.textColor = textColor
        self.textSelectedColor = textSelectedColor
        self.backgroundColor = backgroundColor
        self.backgroundSelectedColor = backgroundSelectedColor
        self.borderColor = borderColor
        self.borderSelectedColor = borderSelectedColor
        self.borderWidth = borderWidth
        self.borderSelectedWidth = borderSelectedWidth
        self.cornerRadius = cornerRadius
        self.font = font
    }
    
    init(title:String) {
        self.title = title
    }
    
    // Mutable Methdos
    mutating func setTitle(title:String) {
        self.title = title
    }
    
    mutating func setSelection(isSelected:Bool) {
        self.isSelected = isSelected
    }
    
}

