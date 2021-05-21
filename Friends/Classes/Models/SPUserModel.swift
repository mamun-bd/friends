//
//  SPUserModel.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPUserModel: NSObject {
    
    private var firstName = ""
    private var lastName = ""
    private var email = ""
    private var artwork = ""
    private var cell = ""
    private var phone = ""
    public var location : SPLocationModel!
    
    convenience init(information: [String:Any]?) {
        
        self.init()
        
        if let user = information {
            
            if let nameInfo = user[SPConstants.kName] as? [String:Any] {
                if let name = nameInfo[SPConstants.kFirstName] as? String {
                    firstName = name
                }
                if let name = nameInfo[SPConstants.kLastName] as? String {
                    lastName = name
                }
            }
        
            if let mailId = user[SPConstants.kEmail] as? String {
                email = mailId
            }
            if let cellInfo = user[SPConstants.kCell] as? String {
                cell = cellInfo
            }
            if let phoneInfo = user[SPConstants.kPhone] as? String {
                phone = phoneInfo
            }
            
            location = SPLocationModel(information:  user[SPConstants.kLocation] as? [String:Any])
            if let pictureInfo = user[SPConstants.kPicture] as? [String:Any] {
                if let picture = pictureInfo[SPConstants.kLarge] as? String {
                    artwork = picture
                }
            }
            
        }
        
    }

}

extension SPUserModel {
    
    func getUserName() -> String {
        var name = ""
        if self.firstName.count > 0 {
            name = self.firstName
        }
        if self.lastName.count > 0 {
            
            if name.count > 0 {
                name.append(" ")
            }
            name.append(self.lastName)
        }
        return name
    }
    
    func getUserArtwork() -> String {
        var name = ""
        if self.artwork.count > 0 {
            name = self.artwork
        }
        return name
    }
    
    func getPhoneNumber() -> String {
        var name = ""
        if self.phone.isEmpty == false {
            name = self.phone
        }
        return name
    }
    
    func getUserEmailID() -> String {
        var name = ""
        if self.email.count > 0 {
            name = self.email
        }
        return name
    }
    
    func getCountry() -> String {
        var name = ""
        if let information = self.location {
            name = information.getCountry()
        }
        return name
    }
    
    func getAddress() -> String {
        var address = ""
        if let information = self.location {
            address = information.getAddress()
        }
        return address
    }
    
}
