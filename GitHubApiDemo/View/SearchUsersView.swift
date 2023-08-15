//
//  SearchUsersView.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import SwiftUI

struct SearchUsersView: View {
    
    @StateObject var viewModel: SearchUsersViewModel = SearchUsersViewModel()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.items) { item in
                    ZStack(alignment: .leading) {
                        HStack {
                            AvatarImageView(size: 48, url: item.avatarUrl)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.login)
                                    .bold()
                                    .font(.title3)
                                
                                Text(String(item.id))
                                    .font(.system(size: 14))
                            }
                        }
                        
                        NavigationLink(destination: UserDetailView(login: item.login)) {}
                    }
                }
                .listStyle(.plain)
                .navigationTitle(UsedWord.userSearch)
                .searchable(text: $searchText, prompt: "検索")
                .onSubmit(of: .search) {
                    guard !searchText.isEmpty else {
                        print("Empty text")
                        return
                    }
                    
                    viewModel.clearItems()
                    
                    Task {
                        do {
                            try await viewModel.getUsers(query: searchText)
                        } catch {
                            print(error)
                        }
                    }
                }
                
                if viewModel.isFetching {
                    LoadingView()
                        .opacity(viewModel.isFetching ? 1 : 0)
                } else {
                    Text(UsedWord.searchDescription)
                        .opacity(viewModel.items.isEmpty ? 1 : 0)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                if viewModel.isAlertShows {
                    ErrorView(error: viewModel.error ?? .invalidData, isAlertShows: $viewModel.isAlertShows)
                }
            }
        }
    }
}

struct SearchUsersView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersView()
    }
}
