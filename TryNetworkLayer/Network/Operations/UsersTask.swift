//
//  LoginOperation.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation

class UsersTask: Operation {
    
    typealias D = Dispatcher
    typealias R = [GHUser]
    
    // MARK: Request parameters
    var query: String
    
    init(query: String) {
        self.query = query
    }
    
    var request: Request {
        return UserRequests.searchUsers(query: self.query)
    }
    
    func execute(in dispatcher: Dispatcher, completion: @escaping (_ user: [GHUser]?, _ error: Error?) -> Void) {
        do {
            try dispatcher.execute(request: self.request, completion: { (response: Response) in
                
                if let json = response.json {
                    do {
                        let object = try JSONDecoder.decode(json, to: GHSearchResponse.self)
                        completion(object.items, nil)
                    } catch let error {
                        completion(nil, error)
                    }

                } else if let error = response.error {
                    completion(nil, error)
                }
            })
        } catch let error {
            print("Network error \(error.localizedDescription)")
        }
    }
}
