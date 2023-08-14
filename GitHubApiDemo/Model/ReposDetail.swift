//
//  ReposDetail.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import Foundation

struct ReposDetail: Codable, Identifiable {
    let id: Int
    let name: String? // リポジトリ名
    let language: String? // 開発言語
    let stargazersCount: Int? // スター数
    let description: String? // 説明文
    let htmlUrl: String? // GitHub Url
    let fork: Bool // forkedリポジトリではないか
}

