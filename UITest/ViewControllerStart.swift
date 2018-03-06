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
    
    @IBOutlet weak var iconQr: UIImageView!
    @IBOutlet weak var iconBar: UIImageView!
    @IBOutlet weak var iconBox: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        /*
        iconQr.layer.cornerRadius = 10
        iconQr.clipsToBounds = true
        iconBar.layer.cornerRadius = 10
        iconBar.clipsToBounds = true
        iconBox.layer.cornerRadius = 10
        iconBox.clipsToBounds = true
        */
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
