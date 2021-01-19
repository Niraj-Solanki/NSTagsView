//
//  NSTagsProperty.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 19/01/21.
//

import UIKit
class NSTagsProperty {
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
}
