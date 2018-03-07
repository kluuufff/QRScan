//
//  TableViewController.swift
//  UITest
//
//  Created by iHope on 07.12.2017.
//  Copyright © 2017 iHope. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    //var models = ["Scan 1", "Scan 2", "Scan 3", "Scan 4", "Scan 5", "Scan 6"]
    var testString = [NSManagedObject]()
    //var transfer = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Архив"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testString.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = testString[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel!.text = product.value(forKey: "codes") as? String
        return cell
    }
}
