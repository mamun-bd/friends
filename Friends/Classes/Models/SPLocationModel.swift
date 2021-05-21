//
//  SPLocationModel.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPLocationModel: NSObject {
    
    private var city = ""
    private var state = ""
    private var country = ""
    private var street : SPStreetModel?
    
    convenience init(information: [String:Any]?) {
        self.init()
        if let user = information {
            if let nameOfCity = user[SPConstants.kCity] as? String {
                city = nameOfCity
            }
            if let nameOfState = user[SPConstants.kState] as? String {
                state = nameOfState
            }
            if let nameOfCountry = user[SPConstants.kCountry] as? String {
                country = nameOfCountry
            }
            street = SPStreetModel(information:  user[SPConstants.kStreet] as? [String:Any])
        }
    }
    
}

extension SPLocationModel {
    
    func getCountry() -> String {
        return self.country
    }
    
    func getAddress() -> String {
        
        var address =  ""
        if let streetInfo = self.street {
            address = streetInfo.getStreetAddress()
        }
        
        var additionalInfo = ""
        if city.isEmpty == false {
            if additionalInfo.isEmpty == false {
                additionalInfo.append(", ")
            }
            additionalInfo.append(city)
        }
        
        if state.isEmpty == false {
            if additionalInfo.isEmpty == false {
                additionalInfo.append(", ")
            }
            additionalInfo.append(state)
        }
        
        if country.isEmpty == false {
            if additionalInfo.isEmpty == false {
                additionalInfo.append(", ")
            }
            additionalInfo.append(country)
        }
        
        if additionalInfo.isEmpty == false {
            if address.isEmpty == false {
                address.append("\n")
            }
            address.append(additionalInfo)
        }
        
        return address
    }

}
