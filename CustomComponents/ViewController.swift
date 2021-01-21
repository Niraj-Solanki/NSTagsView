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
        
        religionTagsView.stringItems = ["One","Two","Three","Four","Five","Niraj Solanki","Six","Seven","Eight","Nine","Niraj Solanki","Ten","Blahh Blahh","Four","Five","Niraj Solanki","Two","Three","Four","Five","Done"]
        religionTagsView.insert(newTag: NSTag.init(title: "Work",leftIcon: UIImage(named: "engineer")), index: 3)
    }


}

