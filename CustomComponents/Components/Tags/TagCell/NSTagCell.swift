//
//  NSTagCell.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 12/01/21.
//

import UIKit

class NSTagCell: UICollectionViewCell {

    //MARK:- Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //Icons
    @IBOutlet weak var rightIconImageView: UIImageView!
    @IBOutlet weak var leftIconImageView: UIImageView!
    @IBOutlet weak var rightIconVIewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftIconViewWidthConstraint: NSLayoutConstraint!
    
    //MARK:- Objects
    var tagModel:NSTag?
    var propertyModel:NSTagsProperty?
    private var ImageIconSize:CGFloat = 24
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            tagModel?.isSelected = isSelected
            commonUpdate()
        }
    }
    
    //MARK:- Custom Methods
    func configureCell(tagModel:NSTag,propertyModel:NSTagsProperty) {
        titleLabel.text = tagModel.title
        
        self.tagModel = tagModel
        self.propertyModel = propertyModel
        
        if tagModel.cornerRadius != nil {
            layer.cornerRadius = tagModel.cornerRadius ?? 0
        }
        else if propertyModel.cornerRadius != 0 {
            layer.cornerRadius = propertyModel.cornerRadius
        }
        else{
            layer.cornerRadius = frame.height / 2
        }

        commonUpdate()
    }
    
    private func commonUpdate() {
        guard let tagModel = tagModel, let propertyModel = propertyModel else { return }
        
        if tagModel.isSelected {
            titleLabel.textColor = (tagModel.textSelectedColor != nil) ? tagModel.textSelectedColor : propertyModel.textSelectedColor
            backgroundColor = (tagModel.backgroundSelectedColor != nil) ? tagModel.backgroundSelectedColor : propertyModel.backgroundSelectedColor
            layer.borderWidth = (tagModel.borderSelectedWidth != nil) ? tagModel.borderSelectedWidth ?? 1 : propertyModel.borderSelectedWidth
            layer.borderColor = (tagModel.borderSelectedColor != nil) ? tagModel.borderSelectedColor?.cgColor : propertyModel.borderSelectedColor.cgColor
            
            //Right Icon
            if tagModel.rightSelectedIcon != nil {
                rightIconImageView.image = tagModel.rightSelectedIcon
                rightIconVIewWidthConstraint.constant = ImageIconSize
            }
            else if propertyModel.rightSelectedIcon != nil
            {
                rightIconImageView.image = propertyModel.rightSelectedIcon
                rightIconVIewWidthConstraint.constant = ImageIconSize
            }
            else{
                rightIconImageView.image = nil
                rightIconVIewWidthConstraint.constant = 0
            }
            
            //Left Icon
            if tagModel.leftSelectedIcon != nil {
                leftIconImageView.image = tagModel.leftSelectedIcon
                leftIconViewWidthConstraint.constant = ImageIconSize
            }
            else if propertyModel.leftSelectedIcon != nil
            {
                leftIconImageView.image = propertyModel.leftSelectedIcon
                leftIconViewWidthConstraint.constant = ImageIconSize
            }
            else{
                leftIconImageView.image = nil
                leftIconViewWidthConstraint.constant = 0
            }
            
        }
        else{
            titleLabel.textColor = (tagModel.textColor != nil) ? tagModel.textColor : propertyModel.textColor
            backgroundColor = (tagModel.backgroundColor != nil) ? tagModel.backgroundColor : propertyModel.backgroundSelectedColor
            layer.borderWidth = (tagModel.borderWidth != nil) ? tagModel.borderWidth ?? 1 : propertyModel.borderWidth
            layer.borderColor = (tagModel.borderColor != nil) ? tagModel.borderColor?.cgColor : propertyModel.borderColor.cgColor
            
            //Right Icon
            if tagModel.rightIcon != nil {
                rightIconImageView.image = tagModel.rightIcon
                rightIconVIewWidthConstraint.constant = ImageIconSize
            }
            else if propertyModel.rightIcon != nil
            {
                rightIconImageView.image = propertyModel.rightIcon
                rightIconVIewWidthConstraint.constant = ImageIconSize
            }
            else{
                rightIconImageView.image = nil
                rightIconVIewWidthConstraint.constant = 0
            }
            
            //Left Icon
            if tagModel.leftIcon != nil {
                leftIconImageView.image = tagModel.leftIcon
                leftIconViewWidthConstraint.constant = ImageIconSize
            }
            else if propertyModel.leftIcon != nil
            {
                leftIconImageView.image = propertyModel.rightIcon
                leftIconViewWidthConstraint.constant = ImageIconSize
            }
            else{
                leftIconImageView.image = nil
                leftIconViewWidthConstraint.constant = 0
            }
        }
        
        
    }

}
