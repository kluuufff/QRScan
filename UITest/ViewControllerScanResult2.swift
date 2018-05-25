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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var errLabel: UILabel!
    
    var stringPassed = ""
    var stringPassed2 = ""
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = 10
        addButton.clipsToBounds = true
        
        //errLabel.sizeToFit()
        
        infoLabel2.text = stringPassed2
        //infoLabel2.text += stringPassed2
        //print(infoLabel2.text)
        
        //theImage.layer.masksToBounds = true
        
        let str = "https://www.googleapis.com/customsearch/v1?q=\(stringPassed)&cx=009299309626749938817%3Af3xdz2eakq4&fileType=.jpg%2C+.png%2C+.bmp&searchType=image&key=AIzaSyDvMGKw1DfmYaWlL9f4SyrnGgzfgaPOeCM"
        //let str = "https://www.googleapis.com/customsearch/v1?q=cat&cx=009299309626749938817%3Af3xdz2eakq4&fileType=.jpg%2C+.png%2C+.bmp&searchType=image&key=AIzaSyDvMGKw1DfmYaWlL9f4SyrnGgzfgaPOeCM"
        //print(str)
        
        let url = URL(string: str+"")
        
        if url != nil {
            errLabel.text = ""
            self.showLoader(show: true)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url!) { (data, _, error) in
                
                if(error == nil) {
                    
                    let swiftyJSON = JSON(data: data!)
                    let theEntryArray = swiftyJSON["items"].arrayValue
                    
                    
                        if theEntryArray.isEmpty == false {
                            let theImageArray = theEntryArray[0]["link"].string!
                            //print(theImageArray)
                            let theImageUrl = URL(string: theImageArray)
                            if let ImageData = NSData(contentsOf: theImageUrl!) {
                                self.showLoader(show: false)
                                DispatchQueue.main.async {
                                    self.theImage.image = UIImage(data: ImageData as Data)
                                }
                                //print("Ok")
                                self.flag = true
                            }
                            
                        } else {
                            self.showLoader(show: false)
                            DispatchQueue.main.async {
                                self.errLabel.text = "Картинок не найдено"
                            }
                        }
                    
                    //поиск следующей картинки
                    /*
                    let strTemp = theImageArray
                    for var i in 1...theEntryArray.count {
                        if strTemp.isEmpty {
                            theEntryArray[i]["link"].string!
                        }
                        i+=i
                        print(strTemp)
                    }*/
                    
                }
            }
            task.resume()
            
        } else {
            errLabel.text = "Картинок не найдено"
        }
    }
    
    
    //loader
    func showLoader(show: Bool){
        DispatchQueue.main.async {
            if show {
                self.theImage.image = nil
                self.loader.startAnimating()
            }
            else {
                self.loader.stopAnimating()
            }
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        
        let myTVC = storyboard?.instantiateViewController(withIdentifier: "ViewControllerTableView") as! ViewControllerTableView
        var strPassed2 = stringPassed2.characters.split{$0 == "\n"}.map(String.init)
        //print("str: "+strPassed2[0])
        
        //if flag == true {
            //myTVC.transfer = stringPassed2
        //}
        if strPassed2.indices.contains(1) {
            //print("yes")
        } else {
            strPassed2.insert("", at: 1)
        }
            myTVC.saveName(code: strPassed2[0], name: strPassed2[1])
            //myTVC.testImage = theImage.image!
            navigationController?.pushViewController(myTVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            //отправка пустой строки в родительский контроллер
            //stringPassed = ""
            //stringPassed2 = ""
        }
    }
    
}

