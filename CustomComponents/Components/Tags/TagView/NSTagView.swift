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
            return ColorKeys.NG100
        case .selected:
            return ColorKeys.P50
        }
    }
    
    //Border Color
    func borderColor() -> UIColor {
        switch self {
        case .normal:
            return ColorKeys.NG300
        case .highlighted:
            return ColorKeys.NG300
        case .selected:
            return ColorKeys.P200
        }
    }
    
    func errorLabelColor() -> UIColor {
        switch self {
        case .normal:
            return ColorKeys.NG800
        case .highlighted:
            return ColorKeys.NG300
        case .selected:
            return ColorKeys.ERROR_SOLID
        }
    }
}
//Optional - tagSelectedCallBack(classView:ComponentView, tag:NSTag,index:Int)

protocol NSTagViewDelegate : AnyObject {
    func didTapOnTag(tagView:NSTagView,tag:NSTag)
}

extension NSTagViewDelegate {
    func didTapOnTag(tagView:NSTagView,tag:NSTag){
        // Now its an optional Methods
    }
}

@IBDesignable class NSTagView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //MARK:- Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: DynamicCollectionView!
    
    //MARK:- Objects
    private var tagsProperty:NSTagsProperty = NSTagsProperty()
    weak var delegate : NSTagViewDelegate?
    private var lastSelectedIndexForSingleSelection = -1 // Default is None
    private var originalItemsForReset:[NSTag] = []
    private var alignedLayout = AlignedLayout()
    
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
            headerLabel.text = headerTitle
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
            alignedLayout.tagsSpacing = tagsSpace
        }
    }
    
    @IBInspectable var linesSpace:CGFloat = 8
    
    @IBInspectable var maxSelectionLimit:Int = 0
    @IBInspectable var maxSelectionLimitExceedMessage:String = ""{
        didSet{
            errorLabel.text = maxSelectionLimitExceedMessage
        }
    }
    
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
        contentView.fixInView(self)
        clipsToBounds = true
        
        collectionView.register(UINib.init(nibName: "NSTagCell", bundle: nil), forCellWithReuseIdentifier: "NSTagCell")
        collectionView.collectionViewLayout = alignedLayout
        resetValue()
        updateUI()
    }
    
    private func resetValue() {
        
    }
    
    //MARK:- Custom Methods
    private func updateUI() {
        
    }
    
    //MARK:- Public Methdos
    func insertTags(newTags:[NSTag])
    {
        items.append(contentsOf: newTags)
    }
    
    func insert(newTag:NSTag,index:Int)
    {
        // Safe Check
        if items.count >= index {
            items.insert(newTag, at: index)
        }
    }
    
    func removeTag(index:Int){
        // Safe Check
        if items.count > index {
            items.remove(at: index)
        }
    }
    
    func removeAllTags(){
        items.removeAll()
    }
    
    func getAllSelectedTags() -> [NSTag]{
        return items.filter({ (currentTag) -> Bool in
            return (currentTag.isSelected == true) ? true : false
        })
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    //MARK:- Animations
    
    //MARK:- CollectionView Delegate & Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell:NSTagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NSTagCell", for: indexPath) as!  NSTagCell
        tagCell.configureCell(tagModel: items[indexPath.row],propertyModel: tagsProperty)
        return tagCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // If Tag selection is not enabled then return.
        if !items[indexPath.row].enableSelection {
            return
        }
        
        // Validate Selections
        switch selectionType {
        case .singleSelection:
            
            if isResetEnable {
                if items[indexPath.row].isSelected {
                    items = originalItemsForReset
                }
                else{
                    originalItemsForReset = items
                    items.removeAll()
                    items.append(originalItemsForReset[indexPath.row])
                    items[0].setSelection(isSelected: true)
                }
            }
            else {
                
                var lastIndexPath = IndexPath.init(row: indexPath.row, section: indexPath.section)
                // Mark Selected Current item and set to last select item
                if lastSelectedIndexForSingleSelection == -1
                {
                    items[indexPath.row].setSelection(isSelected:  true)
                    lastSelectedIndexForSingleSelection = indexPath.row
                }
                // if lastSelectedItem is same as current index then set it to false.
                else if lastSelectedIndexForSingleSelection == indexPath.row {
                    items[lastSelectedIndexForSingleSelection].setSelection(isSelected:false)
                    lastSelectedIndexForSingleSelection = -1 // Reset to no selected Item
                }
                // Set false last Selected Item and Mark selected New item.
                else if lastSelectedIndexForSingleSelection > -1 && lastSelectedIndexForSingleSelection <= items.count {
                    items[lastSelectedIndexForSingleSelection].setSelection(isSelected:false)
                    items[indexPath.row].setSelection(isSelected:  true)
                    lastIndexPath.row = lastSelectedIndexForSingleSelection
                    lastSelectedIndexForSingleSelection = indexPath.row
                }
                else
                {
                    // Something went wrong
                }
                
                //Delegate
                delegate?.didTapOnTag(tagView: self, tag: items[indexPath.row])
            }
            collectionView.reloadData()
        case .multiSelection:
            if maxSelectionLimit != 0 {
                if getAllSelectedTags().count < maxSelectionLimit
                {
                    items[indexPath.row].setSelection(isSelected:  !items[indexPath.row].isSelected)
                    errorLabel.textColor = SelectionEnum.normal.errorLabelColor()
                }
                else if items[indexPath.row].isSelected && getAllSelectedTags().count >= maxSelectionLimit {
                    items[indexPath.row].setSelection(isSelected: false)
                    errorLabel.textColor = SelectionEnum.normal.errorLabelColor()
                }
                else{
                    errorLabel.textColor = SelectionEnum.selected.errorLabelColor()
                }
            }
            else
            {
                items[indexPath.row].setSelection(isSelected:  !items[indexPath.row].isSelected)
            }
            collectionView.reloadData()
            
            //Delegate
            delegate?.didTapOnTag(tagView: self, tag: items[indexPath.row])
        default:
            print("Dont have to do annything. for noSelection")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForIndex(index: indexPath.row, collectionWidth: collectionView
                                .frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return linesSpace
    }
    
    private func sizeForIndex(index:Int,collectionWidth:CGFloat) -> CGSize {
        
        let sizingCell:NSTagCell = (UINib.init(nibName: "NSTagCell", bundle: nil).instantiate(withOwner: nil, options: nil).first as? NSTagCell)!
        
        var size = sizingCell.frame.size
        sizingCell.titleLabel.text = items[index].title
        // Left Right Margin + Icon Size
        size.width = (sizingCell.titleLabel.intrinsicContentSize.width + 24) + iconSize(index: index
        )
        size.width = min(size.width,collectionWidth - 16)
        return size
    }
    
    private func iconSize(index:Int) -> CGFloat {
        var newSize:CGFloat = 0
        
        if items[index].isSelected {
            //Right Icon
            if (items[index].rightSelectedIcon != nil ||  tagsProperty.rightSelectedIcon != nil) && items[index].isSelected
            {
                newSize = 24
            }
            
            //Left Icon
            if (items[index].leftSelectedIcon != nil ||  tagsProperty.leftSelectedIcon != nil) && items[index].isSelected
            {
                newSize = newSize + 24
            }
        }
        else{
            //Right Icon
            if items[index].rightIcon != nil ||  tagsProperty.rightIcon != nil  {
                newSize = 24
            }
            //Left Icon
            if items[index].leftIcon != nil || tagsProperty.leftIcon != nil  {
                newSize = newSize + 24
            }
        }
        return newSize
    }
}

class AlignedLayout: UICollectionViewFlowLayout {
    
    //MARK:- Properties
    var tagsSpacing:CGFloat = 8
    
    //MARK:- Override Methods
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
       return leftAlign(rect: rect)
    }
    
    private func leftAlign(rect:CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            
            leftMargin += layoutAttribute.frame.width + tagsSpacing
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

public class DynamicCollectionView: UICollectionView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        if !bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        let intrinsicContentSize: CGSize = contentSize
        return intrinsicContentSize
    }
}

