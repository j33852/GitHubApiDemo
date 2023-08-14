//
//  AppError.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

enum AppError: Error {
    case networkProblem
    case invalidUrl
    case invalidResponse
    case invalidData
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .invalidData:
            return "Invalid data"
        case .networkProblem:
            return "Network problem"
        }
    }
}
