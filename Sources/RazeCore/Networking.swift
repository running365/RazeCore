//
//  Networking.swift
//  RazeCore
//
//  Created by kim on 2021/5/17.
//

import Foundation

protocol NetworkSession {
    func get(from url:URL, completionHandler:@escaping(Data?,Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) {data,_,error in
            completionHandler(data,error)
        }
        task.resume()
    }
}

extension RazeCore {
    
    
    public class Networking {
        
        /// Responsible for handling all networking calls
        /// - Warning: Must create before using any public APIs
        public class Manager {
            
            public init(){}
            
            internal var session:NetworkSession = URLSession.shared
            
            /// Calls to the live inernet to retrieve data from data form
            /// - Parameters:
            ///   - url: the location you wish to fetch data from
            ///   - completionHandler: returns a result object which signifies the status of the request
            public func loadData(from url: URL, completionHandler:@escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { (data, error) in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
    
}


/*
     private let session = URLSession.shared

     let task = session.dataTask(with: url) {data,response,error in
         let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
         completionHandler(result)
     }
     task.resume()
 */
