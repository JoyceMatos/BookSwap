//
//  TestTableViewController.swift
//  BookSwap
//
//  Created by Joyce Matos on 7/25/17.
//  Copyright © 2017 Joyce Matos. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController {
    
    var someArray = [Int]()
    var vm: TableViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = TableViewModel()
        //fetch some data 
        //populate some local array
        
        // Uncomment the following line to preser)
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return someArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = vm.getTitleForRow(at: indexPath.row)
        //cell.profileImage

        return cell
    }
    
    
    // when user hits like button
    // when user hits comment etc
 


}




class TableViewModel {
    var intArray = [Int]()
    init() {
        // fetch from api
        
    }
    
    
    func getTitleForRow(at index:Int) -> String {
        // look at array get some info
        return String(intArray[index])
    }
}
