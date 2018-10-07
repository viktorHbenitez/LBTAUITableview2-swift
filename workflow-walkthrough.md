
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

