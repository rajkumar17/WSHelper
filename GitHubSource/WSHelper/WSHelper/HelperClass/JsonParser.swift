//
//  JsonParser.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/6/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

class JsonParser{
    
    class func insertItem(reponse: NSDictionary) {
     let appDelegate = AppDelegate.sharedInstanceAppDelegate()
      appDelegate.saveContext()
    }
}
