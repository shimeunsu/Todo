//
//  CategoryViewController.swift
//  Todo
//
//  Created by Eun Su Swhim on 2018-08-11.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    
    let realm = try! Realm()
    var categories: Results<Category>?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        tableView.separatorStyle = .none
            }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return categories?.count ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row]{
        cell.textLabel?.text = category.name
        guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
        cell.textLabel?.textColor = ContrastColorOf(categoryColour, returnFlat: true)
        
        }
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods (save and load data)
    
    func save(category: Category){
        do{
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("error saving context \(error)!")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
 
        categories = realm.objects(Category.self)

        tableView.reloadData()
    }
    
    //MARK - Delete Data from Swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = self.categories?[indexPath.row]{
                do{
                    try self.realm.write {
                        self.realm.delete(categoryForDeletion)
                    }
                }
                catch{
                    print("error deleting")
                }
            }
    }
    //MARK - Add New Categories
    
    @IBAction func adduttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat.hexValue()
            self.save(category: newCategory)
            self.tableView.reloadData()
    
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated:true, completion : nil)
    }
 
    //MARK: = TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            
        }
    }
    //MARK: - Tableview Delegate Methods
    
   
}
