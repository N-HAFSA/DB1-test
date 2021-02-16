//
//  APIRequestFetcher.swift
//  DB1-test
//
//  Created by Suporte on 16/02/21.
//

import Foundation
import Alamofire
 

enum NetworkError: Error {
    case failure
    case success
}

class APIRequestFetcher {
 
    func search(completionHandler: @escaping (Transaction?, NetworkError) -> ()) {
        
        let session = URLSession.shared
        let url = URL(string: "https://api.blockchain.info/charts/transactions-per-second")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            
       // Check the response
       print(response)
       
       // Check if an error occured
       if error != nil {
           // HERE you can manage the error
           completionHandler(nil, .failure)
           return
       }
       
       // Serialize the data into an object]\
            
       do {
        let results = try JSONDecoder().decode(Transaction.self, from: data!)
           print(results)
        completionHandler(results, .success)
       } catch {
           print("Error during JSON serialization: \(error.localizedDescription)")
           completionHandler(nil, .failure)
       }
       
   })
   task.resume()
        
        }
    }
