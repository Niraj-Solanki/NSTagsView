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
}

enum SelectionEnum:Int {
    case normal
    case highlighted
    case selected
    
    //Text Colors
    func textColor() -> UIColor {
        switch self {
        case .normal:
            return ColorKeys.NG500
        case .highlighted:
            return ColorKeys.NG800
        case .selected:
            return ColorKeys.NG800
        }
    }
    
    //Background Color
    func backgroundColor() -> UIColor {
        switch self {
        case .normal:
            return ColorKeys.NG100
        case .highlighted:
            return ColorKeys.NG300
        case .selected:
            return ColorKeys.NG300
        }
    }
    
    //Border Color
    func borderColor() -> UIColor {
        switch self {
        case .normal:
            return ColorKeys.P50
        case .highlighted:
            return ColorKeys.P200
        case .selected:
            return ColorKeys.P200
        }
    }
}

@IBDesignable class NSTagView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- Objects
    private var tagsProperty:NSTagsProperty = NSTagsProperty()
    
    //MARK:- Properties
    var selectionType:NSTagViewSelectionType = .singleSelection{
        didSet{
            updateUI()
        }
    }
    
    var items:[NSTag] = [] // Default is []
    
    var stringItems:[String] = []{
        didSet{
            // Transform String to NSTag
            items.removeAll()
            for value in stringItems {
                let newTag = NSTag.init(title: value)
                items.append(newTag)
            }
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
    
    @IBInspectable var headerTitle:String = "" {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var isResetEnable:Bool = false {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var leftIcon:UIImage? = nil {
        didSet{
            tagsProperty.leftIcon = leftIcon
            updateUI()
        }
    }
    
    @IBInspectable var rightIcon:UIImage? = nil {
        didSet{
            tagsProperty.rightIcon = rightIcon
            updateUI()
        }
    }
    
    @IBInspectable var leftSelectedIcon:UIImage? = nil {
        didSet{
            tagsProperty.leftSelectedIcon = leftSelectedIcon
            updateUI()
        }
    }
    
    @IBInspectable var rightSelectedIcon:UIImage? = nil {
        didSet{
            tagsProperty.rightSelectedIcon = rightSelectedIcon
            updateUI()
        }
    }
    
    @IBInspectable var textColor:UIColor = SelectionEnum.normal.textColor() {
        didSet{
            tagsProperty.textColor = textColor
            updateUI()
        }
    }
    
    @IBInspectable var textSelectedColor:UIColor = SelectionEnum.selected.textColor() {
        didSet{
            tagsProperty.textSelectedColor = textSelectedColor
            updateUI()
        }
    }
    
    @IBInspectable var tagBackgroundColor:UIColor = SelectionEnum.normal.backgroundColor() {
        didSet{
            tagsProperty.backgroundColor = tagBackgroundColor
            updateUI()
        }
    }
    
    @IBInspectable var tagBackgroundSelectedColor:UIColor = SelectionEnum.selected.backgroundColor() {
        didSet{
            tagsProperty.backgroundSelectedColor = tagBackgroundSelectedColor
            updateUI()
        }
    }
    
    @IBInspectable var borderColor:UIColor = SelectionEnum.normal.borderColor() {
        didSet{
            tagsProperty.borderColor = borderColor
            updateUI()
        }
    }
    
    @IBInspectable var borderSelectedColor:UIColor = SelectionEnum.selected.borderColor() {
        didSet{
            tagsProperty.borderSelectedColor = borderSelectedColor
            updateUI()
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet{
            tagsProperty.cornerRadius = cornerRadius
            updateUI()
        }
    }
    
    @IBInspectable var borderWidth:CGFloat = 1 {
        didSet{
            tagsProperty.borderWidth = borderWidth
            updateUI()
        }
    }
    
    @IBInspectable var borderSelectedWidth:CGFloat = 1 {
        didSet{
            tagsProperty.borderSelectedWidth = borderSelectedWidth
            updateUI()
        }
    }
    
    
    @IBInspectable var font:UIFont? = nil {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var tagsSpace:CGFloat = 8 {
        didSet{
            
            updateUI()
        }
    }
    
    @IBInspectable var linesSpce:CGFloat = 8 {
        didSet{
            updateUI()
        }
    }
    
    @IBInspectable var maxSelectionLimit:Int = 0
    @IBInspectable var maxSelectionLimitExceedMessage:String = ""{
        didSet{
            updateUI()
        }
    }
    
    
    //    init Methods
    //    initwithNoSelection(Items:[NSTag],headerTitle:String?)
    //    initWithSingleSelection(Items:[NSTag],headerTitle:String?,resetFlag:Bool)
    //    initWithMultiSelection(Items:[NSTag],headerTitle:String?)
    //
    
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
    
    init(frame: CGRect,items:[NSTag],selectionType:NSTagViewSelectionType?,
         headerTitle:String?) {
        
        super.init(frame: frame)
        commonInit()
        
        self.selectionType = selectionType ?? .singleSelection
        self.items = items
        self.headerTitle = headerTitle ?? ""
        
        updateUI()
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



