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
        // TODO: personal access tokenを入力する必要があります。
        request.addValue("", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
