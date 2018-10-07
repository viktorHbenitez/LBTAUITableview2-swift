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
   
     // you should use Custom Delegation properly instead
    func someMethodIWantToCall(cell: UITableViewCell) {
        //        print("Inside of ViewController now...")
        
        // we're going to figure out which name we're clicking on
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        
        let hasFavorited = contact.hasFavorited
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        
        // SHOW THE CHANGE COLOR OF THE accesoryView
        //        tableView.reloadRows(at: [indexPathTapped], with: .fade)
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
    }
    
    var twoDimensionalArray = [
        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"].map{ Contact(name: $0, hasFavorited: false) }),
        ExpandableNames(isExpanded: true, names: [Contact(name: "Patrick", hasFavorited: false)]),
        ]
    
    
    var showIndexPaths = false

    @objc func handleShowIndexPath(){
        print("Tapped the right button")
        
        // important: For animation we have to create a new array por de animation change
        // build all the indexPaths we want to reload
        var indexPathsToReload = [IndexPath]()
        
        // Reload all section in the TableView : Add the element in the new arrContainer
        for section in twoDimensionalArray.indices {
            for row in twoDimensionalArray[section].names.indices {
                print(section, row)
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        
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
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
        

    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        // Add button and change the header height in heightForHeaderInSection method
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section  // important to know what button is tapped
        
        return button
    }
    @objc func handleExpandClose(button: UIButton) {
        print("Trying to expand and close section...")
        
        let section = button.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        // Revert the isExpanded value
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)  // show the exact number in the row in section
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        cell.link = self
        
        let contact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.hasFavorited ? UIColor.red : .lightGray
        
        if showIndexPaths {
            cell.textLabel?.text = "\(contact.name)   Section:\(indexPath.section) Row:\(indexPath.row)"
        }
        
        return cell
        
    }
   
}

