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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            stringPassed = ""
            /*let myVC = storyboard?.instantiateViewController(withIdentifier: "Scan") as! ViewControllerScan
            myVC.parent*/
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "tabelView") as! TableViewController
            //myVC.testString = "123"
        }
}
