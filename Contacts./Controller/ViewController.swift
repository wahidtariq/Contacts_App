//
//  ViewController.swift
//  Contacts.
//
//  Created by wahid tariq on 15/08/21.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var contacts: [ContactDetail]?
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchPeople()
       
    }
        
   func fetchPeople(){
    do{
        
        self.contacts = try context.fetch(ContactDetail.fetchRequest())
      
            self.tableView.reloadData()
        
     
    }
    catch{
        
        print(error)
    }
    
   }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        cell.textLabel?.text = contacts![indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            
            vc.name = contacts![indexPath.row].name!
            vc.phone = contacts![indexPath.row].phoneNumber!
            navigationController?.pushViewController(vc, animated: true)
        }
    }
   

    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        var textField1 = UITextField()
        
        let alert = UIAlertController(title: "Add New Contact", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default) { [self] (action) in

            
            if textField.text == "" && textField1.text == "" {
               
            
            let alert = UIAlertController(title: "Both Fields are empty", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
          
                alert.dismiss(animated: true, completion: .none)
            }
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return
            }
        
            
            let newName = ContactDetail(context: self.context)
            
            
//             create new ContactDetail object
            newName.name = textField.text
            newName.phoneNumber = textField1.text
            // save the data
            do{
                try  self.context.save()
            }
            catch{
                print(error)
            }

//            Reload the data
                self.fetchPeople()
        
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Name"
            textField = alertTextField
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.keyboardType = .numberPad
            alertTextField.placeholder = "Enter Phone Number"
            
            textField1 = alertTextField
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
      
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
        
//            Which contact to remove
            let contactToRemove = self.contacts![indexPath.row]
//            Remove the contact
            self.context.delete(contactToRemove)
//            Save the data
            do{
            try self.context.save()
            }
            catch{
                print(error)
            }
//            Re-fetch the data
            self.fetchPeople()
 
        }
        
        
        let action1 = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            var textField = UITextField()
            var textField1 = UITextField()
//            Which contact to Edit
            let contactToEdit = self.contacts![indexPath.row]
//            Edit the contact
            
            let alert = UIAlertController(title: "Edit The Contact", message: "", preferredStyle: .alert)
            
                alert.addTextField { (alertTextField) in
                alertTextField.text = contactToEdit.name
                   textField = alertTextField
            }
                
                alert.addTextField { (alertTextField) in
                alertTextField.text = contactToEdit.phoneNumber
                    textField1 = alertTextField
            }
             
            let action = UIAlertAction(title: "Save", style:.default) { (alert) in
                
                contactToEdit.name =  textField.text
                contactToEdit.phoneNumber =  textField1.text
            
//                Save the data
                do{
                try self.context.save()
                }
                catch{
                    print(error)
                }
    //            Re-fetch the data
                self.fetchPeople()
        
        }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        return UISwipeActionsConfiguration(actions: [action,action1])
        }
        
        
        
    }
    
    
//


