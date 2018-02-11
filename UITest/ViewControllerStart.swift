//
//  ViewControllerStart.swift
//  UITest
//
//  Created by iHope on 01.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit

class ViewControllerStart: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
