//
//  HttpRequest.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

class HttpRequest {
    
    static func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // personal access token
        request.addValue("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", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
