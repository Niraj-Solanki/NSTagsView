//
//  ViewController.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 12/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var religionTagsView: NSTagView!
    @IBOutlet weak var casteTagsView: NSTagView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        religionTagsView.stringItems = ["One","Two","Three","Four","Five","Niraj Solanki","Six","Seven","Eight","Nine","Niraj Solanki","Ten","Blahh Blahh","Four","Five","Niraj Solanki","Two","Three","Four","Five","Done"]
        religionTagsView.insert(newTag: NSTag.init(title: "+2 More",textColor: UIColor.red, borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), index: 3)
        religionTagsView.delegate = self
        
        
        
        casteTagsView.stringItems = ["One","Two","Three","Four","Five","Niraj Solanki","Six","Seven","Eight","Nine","Niraj Solanki","Ten","Blahh Blahh","Four","Five","Niraj Solanki","Two","Three","Four","Five","Done"]
        casteTagsView.delegate = self
    }
}

extension ViewController : NSTagViewDelegate
{
    func didTapOnTag(tagView: NSTagView, tag: NSTag) {
        if religionTagsView == tagView {
            print("Religion Tag Value is : \(tag.title)")
            
            print("Count Tags \(religionTagsView.getAllSelectedTags().count)")
        }
        else{
            print("Caste Tag Value is : \(tag.title)")
        }
    }
}
