//
//  StoryView.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//


import SwiftUI

struct StoryView: View {
    let story: Story
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: story.thumbnailURL)) { phase in
                    switch phase {
                    case .empty: ProgressView().frame(width: 60, height: 60)
                    case .success(let image): image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    case .failure: Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                    @unknown default: EmptyView()
                    }
                }
                
                if !story.isRead {
                    Circle()
                        .stroke(Color.blue, lineWidth: 3)
                        .frame(width: 68, height: 68)
                }
            }
            Text(story.author)
                .font(.caption)
                .lineLimit(1)
        }
        .onTapGesture {
            onTap()
        }
        .frame(width: 70)
    }
}
