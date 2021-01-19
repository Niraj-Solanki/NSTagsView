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
        var religionTags:[NSTag] = []
        for i in 0...5 {
            let tag = NSTag.init(title: "Demo \(i)",enableSelection: false)
            
            religionTags.append(tag)
        }
        religionTagsView.items = religionTags
        
    }


}

