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
    var textColor:UIColor = SelectionEnum.normal.textColor()
    var textSelectedColor:UIColor = SelectionEnum.selected.textColor()
    var backgroundColor:UIColor = SelectionEnum.normal.backgroundColor()
    var backgroundSelectedColor:UIColor = SelectionEnum.selected.backgroundColor()
    var borderColor:UIColor = SelectionEnum.normal.borderColor()
    var borderSelectedColor:UIColor = SelectionEnum.selected.borderColor()
    var cornerRadius:CGFloat = 0
    var font:UIFont?
    var borderWidth:CGFloat = 1
    var borderSelectedWidth:CGFloat = 1
    var isSelected = false
    var primaryKey = 0
    var enableSelection =  true
}
