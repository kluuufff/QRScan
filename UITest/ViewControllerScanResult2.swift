//
//  ViewControllerScanResult2.swift
//  UITest
//
//  Created by iHope on 07.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit

class ViewControllerScanResult2: UIViewController {
    @IBOutlet weak var infoLabel2: UITextView!
    
    var stringPassed2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel2.text = stringPassed2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            stringPassed2 = ""
        }
    }

}
