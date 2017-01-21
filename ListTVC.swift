//
//  ListTVC.swift
//  ListWithCoreData
//
//  Created by Walid Sassi on 21/01/2017.
//  Copyright © 2017 Walid Sassi. All rights reserved.
//

import UIKit
import CoreData
class ListTVC: UITableViewController {
  var items = [NSManagedObject]()
  // it should be optional
  var managedObjectContext : NSManagedObjectContext?
    override func viewDidLoad() {
      super.viewDidLoad()
    // add reference to the viewContext by using appdelegate reference
    let delegate = UIApplication.shared.delegate as! AppDelegate
    managedObjectContext = delegate.persistentContainer.viewContext
    // call loadData Function
    loadData()
    }
  func loadData(){
    // create NSFetchRequest reference
    let request :NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Items")
    do{
    // retrieve data from Item entity with managedObhectContext object
    let results = try managedObjectContext!.fetch(request)
    // add to items array
    items = results
    // reload tableview Data
    self.tableView.reloadData()
    }
    // id something wrong
    catch {
      fatalError("erreur")
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func Add(_ sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Add Items", message: "what items do you want to add", preferredStyle: UIAlertControllerStyle.alert)
    alertController.addTextField { (textField:UITextField) in
      
    }
    // add addAction button
    let addAction = UIAlertAction(title: "ADD", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
    let text = alertController.textFields?.first
    // add data to the Item Entity
    let entity = NSEntityDescription.entity(forEntityName: "Items", in: self.managedObjectContext!)
    let items = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
    // using KVC pattern to change data in the entity 
    items.setValue(text?.text, forKey: "itemName")
    // now save changing in the Core Data
      do {
        try self.managedObjectContext!.save()
      }catch{
        fatalError("Error")
      }
      // call LoadData Function
    self.loadData()
  
    }
    // add cancel button
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
    // add actions to alert Controller
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    // show alert Controller
    present(alertController, animated: true, completion: nil)
    
  }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell
      let item = items[indexPath.row]
      cell.textLabel?.text = item.value(forKey: "itemName") as? String
      return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
