//
//  UserDetail.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

struct UserDetail: Codable {
    let avatarUrl: String // アイコン画像URL
    let login: String // ユーザー名
    let name: String? // フルネーム
    let followers: Int // フォロワー数
    let following: Int // フォロイー数
}
