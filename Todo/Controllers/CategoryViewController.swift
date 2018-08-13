//
//  CategoryViewController.swift
//  Todo
//
//  Created by Eun Su Shim on 2018-08-11.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()

    }
    
    //MARK: - Tableview Datasource Methods (show data in container)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods (save and load data)
    
    func saveCategory(){
        do{
            try context.save()
        } catch {
            print("error saving context \(error)!")
        }
        tableView.reloadData()
    }
    
    func loadCategory(){
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        } catch{
            print("error fetching data from context \(error)!")
        }
        tableView.reloadData()
    }
    
    //MARK - Add New Categories
    
    @IBAction func adduttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCat = Category(context: self.context)
            newCat.name = textField.text!
            self.categories.append(newCat)
            self.saveCategory()
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
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
    }
    //MARK: - Tableview Delegate Methods
    
   
}
