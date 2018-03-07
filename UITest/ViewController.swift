//
//  ViewController.swift
//  UITest
//
//  Created by iHope on 01.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var inventButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Сканер"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        
        inventButton.layer.cornerRadius = 10
        inventButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
/*
     https://www.google.com.ua/search?q=chocolate&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiNy7TNxJvZAhWBNywKHa6uB3UQ_AUICigB&biw=1439&bih=803
     
     //google cx = '009299309626749938817:f3xdz2eakq4'
     //google json api key: AIzaSyDvMGKw1DfmYaWlL9f4SyrnGgzfgaPOeCM
     //google search api: https://www.googleapis.com/customsearch/v1?q=boom&cx=009299309626749938817%3Af3xdz2eakq4&searchType=image&key={YOUR_API_KEY}
     
     
     //THIS https://www.googleapis.com/customsearch/v1?q=cat&cx=009299309626749938817%3Af3xdz2eakq4&fileType=.jpg%2C+.png%2C+.bmp&searchType=image&key=AIzaSyDvMGKw1DfmYaWlL9f4SyrnGgzfgaPOeCM
*/

}

