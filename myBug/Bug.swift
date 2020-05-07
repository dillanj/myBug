//
//  Bug.swift
//  myBug
//
//  Created by Dillan Johnson on 10/16/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class Bug: NSObject, NSCoding {
    
    var name: String
    var bugDescription: String
    var qualities: String
    let bugKey: String
    

    init ( name: String, description: String, qualities: String ){
    
        self.name = name
        self.bugDescription = description
        self.qualities = qualities
        self.bugKey = UUID().uuidString
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        qualities = aDecoder.decodeObject(forKey: "qualities") as! String
        bugDescription = aDecoder.decodeObject(forKey: "bugDescription") as! String
        bugKey = aDecoder.decodeObject(forKey: "bugKey") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder ){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(qualities, forKey: "qualities")
        aCoder.encode(bugDescription, forKey: "bugDescription")
        aCoder.encode(bugKey, forKey: "bugKey")
        
    }
    
    convenience override init(){
        self.init(name: "", description: "", qualities: "")
    }
}
