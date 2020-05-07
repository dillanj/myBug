//
//  BugListController.swift
//  myBug
//
//  Created by Dillan Johnson on 10/16/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class BugListController: UITableViewController {
    var bugCage: BugCage!
    var imageStore: ImageStore!
    
    required init?(coder aDecoder: NSCoder ){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem ){
        let indexPath = IndexPath( row: bugCage.allBugs.count, section: 0)
        
        //insert this new row into the table
        tableView.insertRows(at: [indexPath], with: .automatic)
     
    }
    
 
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int)->Int{
        return bugCage.allBugs.count

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell{
        
        // create an instance of UITableViewCell, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "BugListCell", for: indexPath) as! BugListCell
        
        
        // set the text on the cell with the name of the item
        let bug = bugCage.allBugs[indexPath.row]
        
        cell.bugNameLabel.text = bug.name
        cell.bugQualities.text = bug.qualities
        
        let key = bug.bugKey

        let imageToDisplay = imageStore.image(forKey: key)
        cell.bugImage.image = imageToDisplay
        cell.bugImage.layer.cornerRadius = 15
        return cell
    }
    
    // CODE TO ALLOW MOVING OF THE TABLEVIEW ITEMS
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
//                            to destinationIndexPath: IndexPath){
//        //update the model
//        bugCage.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let bug = bugCage.allBugs[indexPath.row]
            // remove the bug from the cage
            bugCage.removeBug(bug)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showBug"?:
            // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the bug associated with this row and pass it along
                let bug = bugCage.allBugs[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.bug = bug
                detailViewController.imageStore = imageStore
   
            }// end of if/let
            
        case "addBug"?: // HELP
            let addBug = segue.destination as! addBugController
            addBug.bugCage = bugCage
            addBug.imageStore = imageStore

        default:
            preconditionFailure("Unexpected segue identifier")
        }// end of switch
    }//end of prepare()
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        tableView.rowHeight = 120
    }
    
    
    
    
}
