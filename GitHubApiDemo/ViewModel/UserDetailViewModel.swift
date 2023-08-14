//
//  UserDetailViewModel.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    
    @Published var userDetail: UserDetail?
    
    @MainActor
    func getUser(username: String) async throws {
        let endpoint = "https://api.github.com/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            throw AppError.invalidUrl
        }
        
        let request = HttpRequest.request(url: url)
        
        var data: Data
        var response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw AppError.networkProblem
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AppError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            userDetail = try decoder.decode(UserDetail.self, from: data)
        } catch {
            throw AppError.invalidData
        }
    }
    
}
