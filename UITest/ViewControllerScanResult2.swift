//
//  ViewControllerScanResult2.swift
//  UITest
//
//  Created by iHope on 07.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerScanResult2: UIViewController {
    @IBOutlet weak var infoLabel2: UITextView!
    @IBOutlet weak var theImage: UIImageView!
    
    var stringPassed = ""
    var stringPassed2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel2.text = stringPassed2
        //infoLabel2.text += stringPassed2
        print(infoLabel2.text)
        
        //theImage.layer.masksToBounds = true
        
        let str = "https://www.googleapis.com/customsearch/v1?q=\(stringPassed)&cx=009299309626749938817%3Af3xdz2eakq4&fileType=.jpg%2C+.png%2C+.bmp&searchType=image&key=AIzaSyDvMGKw1DfmYaWlL9f4SyrnGgzfgaPOeCM"
        print(str)
        
        let url = URL(string: str+"")
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url!) { (data, _, error) in
            
            if(error == nil) {
                
                let swiftyJSON = JSON(data: data!)
                let theEntryArray = swiftyJSON["items"].arrayValue
                let theImageArray = theEntryArray[0]["link"].string!
                print(theImageArray)
                let theImageUrl = URL(string: theImageArray)
                if let ImageData = NSData(contentsOf: theImageUrl!) {
                    
                    self.theImage.image = UIImage(data: ImageData as Data)
                    
                    print("Ok")
                }
            }
        }
        task.resume()
    }
 
/*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
*/
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            //отправка пустой строки в родительский контроллер
            //stringPassed = ""
            //stringPassed2 = ""
            
        }
    }
}

