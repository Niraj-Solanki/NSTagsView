//
//  NSTagVIew.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 18/01/21.
//

import UIKit
enum NSTagViewSelectionType:Int {
    case singleSelection = 0
    case multiSelection = 1
    case noSelection = 2
    
//    func placeholderColor() -> UIColor {
//        switch self {
//        case .inactive:
//            return ColorKeys.NG500
//        case .focused:
//            return ColorKeys.NG800
//        case .completed:
//            return ColorKeys.NG400
//        case .success:
//            return ColorKeys.SUCCESS_TYPO
//        case .error:
//            return ColorKeys.ERROR_SOLID
//        case .warning:
//            return ColorKeys.WARNING_TYPO
//        }
//    }
//
//    func statusIcon() -> UIImage? {
//        switch self {
//        case .inactive,.focused,.completed:
//            return nil
//        case .success:
//            return UIImage(named: "success")
//        case .error:
//            return UIImage(named: "error")
//        case .warning:
//            return UIImage(named: "warning")
//        }
//    }
//
//    func assistiveTextColor() -> UIColor {
//        switch self {
//        case .inactive,.focused,.completed:
//            return ColorKeys.NG400
//        case .success:
//            return ColorKeys.SUCCESS_TYPO
//        case .error:
//            return ColorKeys.ERROR_SOLID
//        case .warning:
//            return ColorKeys.WARNING_TYPO
//        }
//    }
//
//    func bottomLineColor() -> UIColor {
//        switch self {
//        case .inactive:
//            return ColorKeys.NG500
//        case .focused:
//            return ColorKeys.NG800
//        case .completed:
//            return ColorKeys.NG400
//        case .success:
//            return ColorKeys.SUCCESS_TYPO
//        case .error:
//            return ColorKeys.ERROR_SOLID
//        case .warning:
//            return ColorKeys.WARNING_TYPO
//        }
//    }
//
//    func bottomLineHeigth() -> CGFloat {
//        switch self {
//        case .focused:
//            return 1
//        default:
//            return 0.5
//        }
//    }
}

@IBDesignable class NSTagView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    //MARK:- Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK:- Objects
    private var selectionType:NSTagViewSelectionType = .singleSelection{
        didSet{
            updateUI()
        }
    }
    
    //MARK:- Inspectable
    @IBInspectable private var type:Int {
        get{
            return selectionType.rawValue
        }
        set{
            selectionType = NSTagViewSelectionType(rawValue: newValue) ?? .singleSelection
        }
    }
    
    
//    init Methods
//    initwithNoSelection(Items:[NSTag],headerTitle:String?)
//    initWithSingleSelection(Items:[NSTag],headerTitle:String?,resetFlag:Bool)
//    initWithMultiSelection(Items:[NSTag],headerTitle:String?)
//
//    Properties
    
    var items:[NSTag] = [] // Default is []
    
    var stringItems:[String] = []{
        didSet{
            // Transform String to NSTag
        }
    }
    
    var headerTitle:String = "" {
        didSet{
            updateUI()
        }
    }
    
    var resetFlag:Bool = false {
        didSet{
            updateUI()
        }
    }
    
    var leftIcon:UIImage? = nil {
        didSet{
            updateUI()
        }
    }
   
    var rightIcon:UIImage? = nil {
        didSet{
            updateUI()
        }
    }
    
    var leftSelectedIcon:UIImage? = nil {
        didSet{
            updateUI()
        }
    }
    
    var rightSelectedIcon:UIImage? = nil {
        didSet{
            updateUI()
        }
    }
    
//    var textColor:UIColor = <#value#>
    
    
    
    
//    SelectionType = .Single // Default
//    headerTitle = “” // Default Nil
//    resetFlag = .true // Default false and only work when selection type is single.
//    leftDefaultIcon = .image/name // Default is nil
//    rightDefaultIcon = .image/name // Default is nil
//    leftSelectedIcon = .image/name // Default is nil
//    rightSelectedIcon = .image/name // Default is nil
//    textColor = .Color// Default is N500
//    textSelectedColor = .Color // Default is N800
//    backgroundColor  = .Color // Default is N100
//    backgroundSelectedColor  = .Color // Default is N300
//    borderColor =.Color // Default is P050
//    borderSelectedColor = .Color // Default is P200
//    cornerRadius = Float // Deafult is Height/2
//    spaceBetweenTags = int // Default is 12
//    spaceBetweenLines = int // Default is 12
//    font = font // Dafault as perDesign
//    borderWidth = float // Default is 1
//    borderSelectedWidth = float // Default is 1
//    maxSelectionLimit = 3 // Default is 0 means all enable only in multiselection
//    maxSelectionLimitExceedMessage = “” // Default (Select max IntValue)
    
    //MARK:- Blocks
    
    
    //MARK:- Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.init(for: NSTagView.self).loadNibNamed("NSTagView", owner: self, options: nil)
        clipsToBounds = true
        contentView.fixInView(self)
        
        collectionView.register(UINib.init(nibName: "NSTagCell", bundle: nil), forCellWithReuseIdentifier: "NSTagCell")
        collectionView.collectionViewLayout = LeftAlignedLayout()
        
        resetValue()
        updateUI()
    }
    
    private func resetValue() {
        
    }
    
    //MARK:- Custom Methods
    private func updateUI() {
     
    }
    
    //MARK:- Public Methods
    

    //MARK:- Animations
    
    //MARK:- CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell:NSTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NSTagCell", for: indexPath) as!  NSTagCell
        tagCell.configureCell(tag: items[indexPath.row])
        return tagCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: Int.random(in: 80..<150), height: 36)
    }
}

class LeftAlignedLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}



