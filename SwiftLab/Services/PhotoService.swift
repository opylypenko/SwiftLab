//
//  PhotoService.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//


import Foundation

class PhotoService {
    func fetchStories(page: Int, limit: Int) async throws -> [Story] {
        let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Story].self, from: data)
    }
}
