//
//  ViewControllerTableView.swift
//  UITest
//
//  Created by iHope on 07.03.2018.
//  Copyright © 2018 iHope. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerTableView: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [NSManagedObject]()
    var transfer = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Архив"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if transfer.isEmpty {
            self.tableView.reloadData()
        }
        else { self.tableView.reloadData() }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
        
        let person = people[indexPath.row]
        cell.textLabel!.text = person.value(forKey: "name") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(people[indexPath.row] )
        do {
            try managedContext.save()
            } catch _ {
            print("Error")
        }
        
        if editingStyle == .delete
        {
            people.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
   /* @IBAction func addName(_ sender: Any) {
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action: UIAlertAction!) -> Void in
                                        
            let textField = alert.textFields![0] as! UITextField
            saveName(name: transfer)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextField {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
   }*/
    
    func saveName(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext

        let entity =  NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto:managedContext)

        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
        //people.append(person)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for data in fetchedResults as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
            }
            people = fetchedResults as! [NSManagedObject]
        } catch {
            print("Failed")
        }
    }
}
