//
//  Dispatcher.swift
//  TryNetworkLayer
//
//  Created by Andrea on 21/08/2017.
//  Copyright © 2017 Ennova Research Srl. All rights reserved.
//

import Foundation
import Alamofire

/// The dispatcher is responsible to execute a Request by calling the underlyning layer (Alamofire or just a fake dispatcher which return mocked results).
/// As output for a Request it should provide a Response.
protocol Dispatcher {
    
    /// Configure the dispatcher with an environment
    ///
    /// - Parameter environment: environment configuration
    init(environment: Environment)
    
    /// This function execute the request and provide a completion handler with the response
    ///
    /// - Parameters:
    ///   - request: request to execute
    ///   - completion: completion handler for the request
    /// - Throws: error
    func execute(request: Request, completion: @escaping (_ response: Response) -> Void) throws
    
}
