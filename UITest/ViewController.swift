//
//  ViewController.swift
//  UITest
//
//  Created by iHope on 01.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Сканер"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        //getImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  /*
    let placeName = "New York"
    
    func getImage() {
        
        let url = URL(string: "https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=\(placeName)")
        let request = URLRequest(url: url! as URL)
        //let test = JSONSerialization.jsonObject(with: go, options: JSONSerialization.ReadingOptions.allowFragments) as
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main){ (response, go, error) -> Void in
            let go = try? JSONSerialization.jsonObject(with: go!, options: JSONSerialization.ReadingOptions.allowFragments) as![String:AnyObject]
            let responseData = go!["responseData"] as! [String:AnyObject]
            let results = responseData["results"] as! [[String:String]]
            let firstObject = results[0]
            let firstURL = firstObject["unescapedUrl"]
            print(responseData)
        }
    }
*/

}

