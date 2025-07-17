//
//  Story.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//


struct Story: Identifiable, Codable, Hashable, Equatable {
    let id: String
    let author: String
    let download_url: String
    
    enum CodingKeys: String, CodingKey {
        case id, author, download_url
    }
    
    var isRead: Bool = false
    var isLiked: Bool = false
    
    var thumbnailURL: String {
        "https://picsum.photos/id/\(id)/100/100"
    }
    
    var fullImageURL: String {
        "https://picsum.photos/id/\(id)/500/300"
    }
}
