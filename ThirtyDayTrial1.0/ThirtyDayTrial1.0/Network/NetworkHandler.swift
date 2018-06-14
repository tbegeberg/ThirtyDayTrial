//
//  NetworkHandler.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 25/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import Foundation
import UIKit

class NetworkHandler {
    
    static let shared = NetworkHandler()
    
    let encoder = JSONEncoder()
    
    func getJSON<T: Codable> (url: String, completionHandler: @escaping (Result<T>)->()) {
        let request = createRequest(url: url, method: "GET")
        let task = self.task(request: request, completionHandler: completionHandler)
        task.resume()
    }
    
    func createRequest (url: String, method: String) -> URLRequest {
        guard let url = URL(string: url) else { fatalError("Could not create URL from components") }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
    
    func decode<T: Codable>(data: Data, completionHandler: @escaping (Result<T>)->()) {
        let decode = JSONDecoder()
        
        do {
            let value = try decode.decode(T.self, from: data)
            DispatchQueue.main.async {
                completionHandler(Result.success(value))
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(Result.error(error))
            }
        }
    }
    
    func decocdeServerError<T: Codable>(data: Data, completionHandler: @escaping (Result<T>)->()) {
        let decode = JSONDecoder()
        do {
            let value = try decode.decode(ServerError.self, from: data)
            DispatchQueue.main.async {
                completionHandler(Result.serverError(value))
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(Result.error(error))
            }
        }
    }
    
    func task<T: Codable> (request: URLRequest, completionHandler: @escaping (Result<T>)->()) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            guard let data = responseData else {
                print("Error: did not receive data")
                if let error = error {
                    DispatchQueue.main.async {
                        completionHandler(Result.error(error))
                    }
                }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse  {
                switch httpResponse.statusCode {
                case 200:
                    self.decode(data: data, completionHandler: completionHandler)
                case 400, 401, 403, 404, 500:
                    self.decocdeServerError(data: data, completionHandler: completionHandler)
                default:
                    break
                }
            }
        }
        return task
    }
}


