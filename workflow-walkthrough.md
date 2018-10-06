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

