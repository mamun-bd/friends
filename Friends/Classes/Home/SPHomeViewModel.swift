//
//  SPHomeViewModel.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPHomeViewModel: NSObject {
    
    private var users = [SPUserModel]()
    
    typealias UserCompletionHandler = ([SPUserModel]) -> Void
    
    func fetchUserInformation(withCompletion handler: @escaping UserCompletionHandler) {
        self.getInformationToServer(withCompletion: handler)
    }
    
    func getInformationToServer(withCompletion handler: @escaping UserCompletionHandler) {
        
        var receivedUsers = [SPUserModel]()
        let urlLink = "https://randomuser.me/api/?results=10"
        guard let url = URL(string: urlLink) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let responseData = data, error == nil else {
                handler(receivedUsers)
                return
            }
            
            do {
                let information =  try JSONSerialization.jsonObject(with: responseData, options: [.allowFragments]) as? [String:Any]
                if let users = information?["results"] as? [[String:Any]] {
                    for userItem in users {
                        let user = SPUserModel.init(information: userItem)
                        receivedUsers.append(user)
                    }
                    handler(receivedUsers)
                } else {
                    handler(receivedUsers)
                }
            } catch{
                print(error)
                handler(receivedUsers)
            }
            
        }.resume()
        
    }

}
