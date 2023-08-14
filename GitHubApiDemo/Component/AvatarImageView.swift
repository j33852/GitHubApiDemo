//
//  AvatarImageView.swift
//  GitHubApiDemo
//
//  Created by 張俊傑 on 2023/08/14.
//

import SwiftUI

struct AvatarImageView: View {
    
    @State var size: CGFloat = 0
    @State var url: String = ""
    
    var body: some View {
        
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
        } placeholder: {
            Circle()
                .foregroundColor(.gray)
        }
        .frame(width: size, height: size)
        
    }
}

struct AvatarImageView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarImageView()
    }
}
