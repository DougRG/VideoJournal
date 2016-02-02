//
//  ListTableViewController.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/3/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//

import UIKit



class EntryListTableViewController: UITableViewController {
    
    var entry: Entry?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedController.entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)

        let entry = EntryController.sharedController.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let entry = EntryController.sharedController.entries[indexPath.row]
            
            EntryController.sharedController.removeEntry(entry)
            
            // Delete the row from the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "toShowEntry" {
            
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController {
                
                // Following line forces the view from Storyboard to load UI elements to make available for testing
                _ = detailViewController.view
                
                let indexPath = tableView.indexPathForSelectedRow
                
                if let selectedRow = indexPath?.row {
                    let entry = EntryController.sharedController.entries[selectedRow]
                    detailViewController.entry = self.entry
                    
                    detailViewController.updateWithEntry(entry)
                }
            }
        } else if segue.identifier == "toAddEntry" {
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController {
                _ = detailViewController.view
                
                detailViewController.entry = self.entry
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
