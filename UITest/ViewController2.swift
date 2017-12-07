//
//  ViewController2.swift
//  UITest
//
//  Created by iHope on 01.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Архив"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
