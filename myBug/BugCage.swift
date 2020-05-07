//
//  BugCage.swift
//  myBug
//
//  Created by Dillan Johnson on 10/16/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class BugCage {
    var allBugs = [Bug]()
    
    let bugArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("bugs.archive")
    }()
    
    init() {
        
        if let archivedBugs = NSKeyedUnarchiver.unarchiveObject(withFile: bugArchiveURL.path) as? [Bug]{
            allBugs = archivedBugs
        }
        
    }
    
    func moveItem( from fromIndex: Int, to toIndex: Int ){
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being moved so we can reinsert it
        let movedBug = allBugs[fromIndex]
        
        // remove item from array
        allBugs.remove(at: fromIndex)
        
        //insert item in array at new location
        allBugs.insert(movedBug, at: toIndex)
    }
    
    func removeBug(_ bug: Bug ){
        if let index = allBugs.firstIndex(of: bug){
            allBugs.remove(at: index)
        }
    }
    
    func saveChanges() -> Bool {
        print("saving bugs to \(bugArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allBugs, toFile: bugArchiveURL.path)
    }
}
