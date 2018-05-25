//
//  ViewControllerTableViewCellsInfo.swift
//  UITest
//
//  Created by iHope on 19.03.2018.
//  Copyright © 2018 iHope. All rights reserved.
//

import UIKit

class ViewControllerTableViewCellsInfo: UIViewController {
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel2: UILabel!
    
    
    var code = ""
    var country = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeLabel.text = code
        countryLabel.text = country

        // Do any additional setup after loading the view.
    }

    @IBAction func shareButton(_ sender: Any) {
        // text to share
        let text = "\(nameLabel.text!)\n\(codeLabel.text!)\n\(nameLabel2.text!)\n\(countryLabel.text!)"
        
        // set up activity view controller
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        //activityViewController.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.postToFacebook]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
