//
//  SearchItem.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

struct SearchItem: Identifiable, Codable {
    let login: String // ユーザー名
    let id: Int
    let avatarUrl: String // アイコン画像URL
}

struct SearchItems: Codable {
    let items: [SearchItem]
}
