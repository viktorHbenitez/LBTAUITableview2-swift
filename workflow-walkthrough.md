

# UITableView Contacts

![imagen](../feature-AnimationRowsInUITableView/assets/sketch2.gif) 

## 3. Expandable Header UITableView

[LBTA ] (https://www.letsbuildthatapp.com/course_video?id=2242)


### Steps

1. Create a Model  `ExpandableNames.swift`  and change de elements with the atribut  `isExpanded`   
2.  Create a button in the header tableView `button.tag = section` important to now what section is tapped  
2.1 `isExpanded` to delete or insert elements in the TableView  
3. In `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int` change the elements to show 

```swift
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }
        
        return twoDimensionalArray[section].names.count

    }

```
**Show the text when the animation is presented**  

1.  In `override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)` use the `showIndexPaths` bool value to show de description  

# UITableView Contacts

![imagen](../feature-AnimationRowsInUITableView/assets/sketch2.gif) 

## 1. Animations Reload Rows in UITableView

[LBTA ] (https://www.letsbuildthatapp.com/course_video?id=2232)


### Steps

1. In `ViewController.swift`  `func application(_ application: UIApplication, didFinishLaunchingWithOptions`   add a right Bar Button Item  that change the present the element in the tableView  
2.  Change the animation of the tableview  `UITableViewRowAnimation.right : .left`
2.1 When the user tap the right bar button we can see the animation and the tex in the tableView 

```swift
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
        
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableViewRowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)

    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a UIBarButtonItem
          navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
       ...
    }

```
**Show the text when the animation is presented**  

1.  In `override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)` use the `showIndexPaths` bool value to show de description  

# UITableView Section Intelligently

![imagen](../feature-UITableViewSection/assets/sketch1.gif) 
## 1. How to implement UITableView Sections Intelligently

[LBTA ] (https://www.letsbuildthatapp.com/course_video?id=2222)


### Steps

1. In `class AppDelegate`  `func application(_ application: UIApplication, didFinishLaunchingWithOptions`  create a window for change the ViewController to UITableViewController
2.  Add Navigation Controller to the `UIViewController `

```swift
        // 1. Manually create a window fo the UITableView
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        // 2. add navigation bar to the tableView
        let navController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navController

```
**Implement a basic UITableView (basic methods)**  

1. `override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {}`   
2. `override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {}`   
3. `tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)`  `//tableView.dequeueReusableCell needs to register a cell `  

