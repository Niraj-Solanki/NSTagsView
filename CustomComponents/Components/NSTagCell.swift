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
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    //MARK:- Custom Methods
    func configureCell(tag:NSTag) {
        titleLabel.text = tag.title
    }

}
