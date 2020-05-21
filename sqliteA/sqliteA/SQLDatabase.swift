//
//  SQLDatabase.swift
//  sqliteA
//
//  Created by Vadde Narendra on 12/22/19.
//  Copyright © 2019 Varalakshmi Kacherla. All rights reserved.
//

import UIKit
import SQLite

class SQLDatabase: NSObject
{
    static var shared:SQLDatabase = SQLDatabase()
    
    var dbConnection:Connection!
    var deleteBtnTag:Int!
    var buttonTapped:Int!
    var firstNamesArray = [String]()
    var lastNameArray = [String]()
    var mobileNoArray = [String]()
    var isCreateBtnTab = false
    var idsArray = [Int64]()
    
    private override init() {
        super.init()
    }

}
