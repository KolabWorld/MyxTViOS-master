//
//  ApplicationLogsData.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 08/08/22.
//

import Foundation
import RealmSwift
class ApplicationLogsData: Object {
    @objc dynamic var stateName = ""
    @objc dynamic var timeStamp = Date().millisecondsSince1970

  
}
