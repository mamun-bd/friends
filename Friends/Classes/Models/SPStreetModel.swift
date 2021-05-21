//
//  SPStreetModel.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPStreetModel: NSObject {
    
    private var number : Double = 0
    private var name = ""
    
    convenience init(information: [String:Any]?) {
        
        self.init()
        if let user = information {
            if let streetNumber = user[SPConstants.kStreetNumber] as? Double {
                number = streetNumber
            }
            if let streetName = user[SPConstants.kStreetName] as? String {
                name = streetName
            }
        }
        
    }

}

extension SPStreetModel {
    
    func getStreetAddress() -> String {
        var address = ""
        if self.number > 0 {
            address = "\(self.number)"
        }
        if self.name.isEmpty == false {
            if address.isEmpty == false {
                address.append(", ")
            }
            address.append(self.name)
        }
        return address
    }
    
}
