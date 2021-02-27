//
//  Networking.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

enum MethodType {
  case POST
  case GET
}

struct Networking {
  
  func performNetworkTask<T: Codable>(method: MethodType,
                                      endpoint: PokemonAPI,
                                      dictionary:[String:String]?,
                                      type: T.Type,
                                      completion: ((_ response: T?, _ error: String?) -> Void)?) {
    
    let urlString = endpoint.path.isEmpty ? "\(endpoint.baseURL)" : endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
    
    guard let url = URL(string: urlString ?? "") else { return }
    
    var request = URLRequest(url: url)
    
    if method == .POST
    {
      request.httpMethod = "\(method)"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      if let postBody = dictionary {
        guard let httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: []) else {
          completion?(nil,"Error in post data")
          return
        }
        request.httpBody = httpBody
      }
    }
    
    let urlSession = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
      
      if let httpResponse = urlResponse as? HTTPURLResponse  {
        if httpResponse.statusCode != 200 {
          completion?(nil,"No Data Found")
          return
        }
      }
      if let _ = error {
        completion?(nil,error?.localizedDescription)
        return
      }
      guard let data = data else {
        completion?(nil,"No data available")
        return
      }
      let response = Response()
      do {
        let decoded = try response.decode(type.self, data: data)
        completion?(decoded,nil)
      } catch let error{
        completion?(nil,error.localizedDescription)
      }
      
    }
    urlSession.resume()
  }
}
