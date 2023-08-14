//
//  UserDetailView.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.openURL) var openURL
    
    @State private var orientation = UIDeviceOrientation.unknown
    @StateObject var userDetailViewModel: UserDetailViewModel = UserDetailViewModel()
    @StateObject var reposDetailViewModel: ReposDetailViewModel = ReposDetailViewModel()
    
    var login: String
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                userDetailContent
                
                Divider()
                    .padding(.top, 15)
                
                if reposDetailViewModel.isFetching {
                    LoadingView()
                        .padding(.top, 30)
                } else {
                    if reposDetailViewModel.items.count > 0 {
                        repositoriesContent
                    } else {
                        Text(UsedWord.noData)
                            .padding(.top, 30)
                    }
                }
                
            }
        }
        .navigationTitle(UsedWord.user)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 15)
        .padding(.horizontal, 30)
        .task {
            do {
                try await userDetailViewModel.getUser(username: login)
                try await reposDetailViewModel.getUser(username: login)
            } catch {
                print(error)
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(login: "iamshaunjp")
    }
}

extension UserDetailView {

    // ユーザーの詳細情報
    var userDetailContent: some View {
        HStack {
            AsyncImage(url: URL(string: userDetailViewModel.userDetail?.avatarUrl ?? "")) { image in
                image
                    .resizable()

            } placeholder: {
                LoadingView()
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 3.0))
            .shadow(radius: 8)
            .aspectRatio(contentMode: .fit)
            
            Spacer().frame(width: 16)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(userDetailViewModel.userDetail?.name ?? "").font(.title2.bold())
                HStack {
                    Text(userDetailViewModel.userDetail?.login ?? "").font(.subheadline)
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                        .foregroundColor(.blue)
                    Text("Followes:\(userDetailViewModel.userDetail?.followers ?? 0)．Following: \(userDetailViewModel.userDetail?.following ?? 0)")
                        .font(.system(.caption2, design: .rounded).bold())
                        .fontWeight(.light)
                }
            }
            
            Spacer()

        }
    }
    
    // ユーザーのリポジトリ
    var repositoriesContent: some View {
        VStack(alignment: .leading) {
            Text(UsedWord.repository)
                .font(.system(.title, design: .rounded).bold())
                .padding(.leading, 8)
            LazyVStack (alignment: .leading, spacing: 16) {
                
                ForEach(reposDetailViewModel.items) { item in
                    VStack(alignment: .leading) {
                        Text(item.name ?? "")
                            .font(.system(.title, design: .rounded)).fontWeight(.medium)
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.blue)
                            .lineLimit(2)
                            .frame(alignment: .leading)
                        
                        Text(item.description ?? "")
                            .font(.system(.body, design: .rounded)).fontWeight(.regular)
                            .foregroundColor(.black)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "star.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                               
                            
                            Text("\(item.stargazersCount ?? 0)")
                                .font(.system(.callout, design: .rounded))
                                .fontWeight(.light)
                        }
                        .foregroundColor(.gray)
                            
                        HStack {
                            Circle()
                                .frame(width: 16, height: 16)
                                .foregroundColor(.red)
                            Text(item.language ?? "")
                                .font(.system(.title3, design: .rounded)).fontWeight(.medium)
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color(hex: "#F5F5F5"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.orange, lineWidth: 1)
                    )
                    .padding([.leading, .trailing], 8)
                    .onTapGesture {
                        openURL(URL(string: item.htmlUrl ?? "")!)
                    }
                }
            }
        }
    }
}
