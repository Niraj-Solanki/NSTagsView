//
//  ViewController.swift
//  CustomComponents
//
//  Created by Neeraj Solanki on 12/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var religionTagsView: NSTagView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        religionTagsView.rightSelectedIcon = UIImage.init(named: "tick")
        religionTagsView.rightIcon = UIImage.init(named: "plusIcon")
        religionTagsView.stringItems = ["One","Two","Three","Four","Five"]
        religionTagsView.insert(newTag: NSTag.init(title: "Work",rightIcon: UIImage(named: "engineer")), index: 3)
    }


}

