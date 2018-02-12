//
//  ViewControllerScanResult.swift
//  UITest
//
//  Created by iHope on 07.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit

class ViewControllerScanResult: UIViewController {
    @IBOutlet weak var infoLabel: UITextView!
    
    var stringPassed = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = stringPassed
    }

    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            stringPassed = ""
        }
    }
    
}
