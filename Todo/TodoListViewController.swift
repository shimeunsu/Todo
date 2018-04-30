//
//  ViewController.swift
//  Todo
//
//  Created by Eun Su Shim on 2018-04-28.
//  Copyright © 2018 Eun Su Shim. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike", "Buy Eggs", "HQ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

//MARK - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
         else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType =.checkmark
        }
            tableview.deselectRow(at: indexPath, animated: true)
        
        
    }

}





