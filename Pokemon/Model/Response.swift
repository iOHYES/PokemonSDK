//
//  Response.swift
//  NetworkingLayer
//
//  Created by Arturs Derkintis on 01/11/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import Foundation

struct Response {
}

extension Response {
  public func decode<T: Codable>(_ type: T.Type, data: Data) throws -> T?
  {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch let error {
          throw error
        }
    }
}
