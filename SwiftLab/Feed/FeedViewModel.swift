//
//  FeedViewModel.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//


import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var selectedStory: Story?
    var selectedStoryIndex: Int? {
        guard let selected = selectedStory else { return nil }
        return stories.firstIndex(of: selected)
    }
    
    private let service = PhotoService()
    
    private var currentStoryPage = 1
    private let storyLimit = 10
    private var isLoadingStories = false
    private(set) var allStoriesLoaded = false
    
    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { await self.loadMoreStoriesIfNeeded(currentItem: nil) }
            }
        }
    }
    
    func loadMoreStoriesIfNeeded(currentItem: Story?) async {
        guard !isLoadingStories && !allStoriesLoaded else { return }
        
        guard let currentItem else {
            await loadStoriesPage()
            return
        }
        
        guard let currentIndex = stories.firstIndex(where: { $0.id == currentItem.id }) else { return }
        
        let thresholdIndex = stories.index(stories.endIndex, offsetBy: -5, limitedBy: stories.startIndex) ?? stories.startIndex
        
        if currentIndex >= thresholdIndex {
            await loadStoriesPage()
        }
    }

    private func loadStoriesPage() async {
        isLoadingStories = true
        defer { isLoadingStories = false }
        
        do {
            let newStories = try await service.fetchStories(page: currentStoryPage, limit: storyLimit)
            if newStories.isEmpty {
                allStoriesLoaded = true
            } else {
                currentStoryPage += 1
                stories.append(contentsOf: newStories)
                print("✅ Added \(newStories.count) new stories, Total: \(stories.count)")
            }
        } catch {
            print("❌ Failed to load stories: \(error)")
        }
    }

    func markStoryAsRead(_ story: Story) {
        guard let index = stories.firstIndex(of: story) else { return }
        stories[index].isRead = true
    }
    
    func toggleLike(for story: Story) {
        guard let index = stories.firstIndex(of: story) else { return }
        stories[index].isLiked.toggle()
    }
}
