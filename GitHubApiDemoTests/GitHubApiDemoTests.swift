//
//  GitHubApiDemoTests.swift
//  GitHubApiDemoTests
//
//  Created by 張俊傑 on 2023/08/14.
//

import XCTest

@testable import GitHubApiDemo

final class GitHubApiDemoTests: XCTestCase {
    var sut: SearchUsersViewModel!

    func testSearchUsersViewModel() async throws {
        sut = .init()
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let testString = String((0..<10).map { _ in characters.randomElement()! })
        
        try await sut.getUsers(query: testString)
        // テストでは空の値は返されないようになっています。
        XCTAssertNotNil(sut.items)
        
    }


}
