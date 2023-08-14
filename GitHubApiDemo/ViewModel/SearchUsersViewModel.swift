//
//  SearchUsersViewModel.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

class SearchUsersViewModel: ObservableObject {
    
    @Published var items: [SearchItem] = []
    @Published var isFetching: Bool = false
    @Published var isAlertShows: Bool = false
    
    var error: AppError? = nil
    
    @MainActor
    func getUsers(query: String) async throws  {
        let _query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let endpoint = "https://api.github.com/search/users?q=\(_query)"
        
        isFetching = true
        
        guard let url = URL(string: endpoint) else {
            setProperties(error: .invalidUrl)
            throw AppError.invalidUrl
        }
        
        let request = HttpRequest.request(url: url)
        
        var data: Data
        var response: URLResponse
        
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            setProperties(error: .networkProblem)
            throw AppError.networkProblem
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            setProperties(error: .invalidResponse)
            throw AppError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            //print(String(data: data, encoding: .utf8))
            let value = try decoder.decode(SearchItems.self, from: data)
            items = value.items
        } catch {
            setProperties(error: .invalidData)
            throw AppError.invalidData
        }

        isFetching = false
    }
    
    func clearItems() {
        items.removeAll()
    }
    
    private func setProperties(error: AppError) {
        isAlertShows = true
        isFetching = false
        self.error = error
    }
    
}
