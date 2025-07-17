//
//  ContentView.swift
//  SwiftLab
//
//  Created by Oleksandr Pylypenko on 17.07.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationView {
            FeedView(viewModel: viewModel)
            .navigationTitle("Swift Lab")
        }
        .fullScreenCover(item: $viewModel.selectedStory) { story in
            StoryDetailView(viewModel: viewModel, initialIndex: viewModel.selectedStoryIndex ?? 0) {
                viewModel.selectedStory = nil
            }
        }
    }
}
