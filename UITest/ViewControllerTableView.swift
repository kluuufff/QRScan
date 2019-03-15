//
//  ViewControllerTableView.swift
//  UITest
//
//  Created by iHope on 07.03.2018.
//  Copyright © 2018 iHope. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var people = [NSManagedObject]()
    var nameLbl = [NSManagedObject]()
    var transfer = String()
    var flag = 0
    
    //var testImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Архив"
        //self.tableView.register(ViewControllerTableViewCell.self, forCellReuseIdentifier: "Cell")
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if transfer.isEmpty {
            self.tableView.reloadData()
        }
        else { self.tableView.reloadData() }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Person")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            for data in fetchedResults as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                //print(data.value(forKey: "code") as! String)
            }
            people = fetchedResults as! [NSManagedObject]
            nameLbl = fetchedResults as! [NSManagedObject]
        } catch {
            //print("Failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (people.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ViewControllerTableViewCell
        //_ = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ViewControllerTableViewCell2
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        
        let person = people[indexPath.row]
        let names = nameLbl[indexPath.row]
        //if flag == 0 {
        cell?.codeLabel?.text = person.value(forKey: "name") as? String
        cell?.nameLabel?.text = names.value(forKey: "code") as? String
       /* }
        if flag == 1 {
            cell2.urlText?.text = person.value(forKey: "name") as? String
        }*/
        //cell.picProducts?.image = testImage
        //cell.textLabel!.text = person.value(forKey: "name") as? String
        /*
        if flag == 0 {
            return cell
        } else {
            return cell2
        }*/
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(people[indexPath.row])
        managedContext.delete(nameLbl[indexPath.row])
        do {
            try managedContext.save()
            } catch _ {
            //print("Error")
        }
        
        if editingStyle == .delete
        {
            people.remove(at: indexPath.row)
            nameLbl.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func saveName(code: String, name: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto:managedContext)
        person.setValue(code, forKey: "name")
        person.setValue(name, forKey: "code")
        //person.setValue(name, forKey: "url")
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
        if name.isEmpty {
            print("name: \(name)")
            flag = 1
        }
        
        //people.append(person)
    }
    
    var cell: ViewControllerTableViewCell?
    
    var myIndex = 0
    
    //var selectedCell: IndexPath = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        //print(people[indexPath.row])
        print(indexPath.row)

        //selectedCell = indexPath

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myVC = segue.destination as! ViewControllerTableViewCellsInfo
        
        //if self.selectedCell.row == myIndex {
            myVC.code = (cell?.codeLabel.text)!
            myVC.country = (cell?.nameLabel.text)!
        //}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
}
