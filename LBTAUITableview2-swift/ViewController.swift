//
//  ViewController.swift
//  LBTAUITableview2-swift
//
//  Created by Victor Hugo Benitez Bosques on 05/10/18.
//  Copyright © 2018 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let cellId = "cellId123123"
    
    let names = [
        "Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"
    ]
    
    let cNames = [
        "Carl", "Chris", "Christina", "Cameron"
    ]
    
    let dNames = [
        "David", "Dan"
    ]
    
    let twoDimensionalArray = [
        ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"],  // Section 0
        ["Carl", "Chris", "Christina", "Cameron"],
        ["David", "Dan"],
        ["Patrick", "Patty"]  // Section 3
    ]
    
    var showIndexPaths = false

    @objc func handleShowIndexPath(){
        print("Tapped the right button")
        
        // important: For animation we have to create a new array por de animation change
        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        // Reload all section in the TableView : Add the element in the new arrContainer
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
        // Reload only section 0
        //        for index in twoDimensionalArray[0].indices {
        //            let indexPath = IndexPath(row: index, section: 0)
        //            indexPathsToReload.append(indexPath)
        //        }
        
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //  tableView.dequeueReusableCell needs to register a cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Header"
        label.backgroundColor = UIColor.lightGray
        return label
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
        //        if section == 0 {
        //            return names.count
        //        }
        //        return cNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
        
        if showIndexPaths {
            cell.textLabel?.text = "\(name)   Section:\(indexPath.section) Row:\(indexPath.row)"
        }else {
            cell.textLabel?.text = name
        }
        
        return cell
        
    }
   
}

