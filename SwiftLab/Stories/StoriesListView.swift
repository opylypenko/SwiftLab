//
//  StoriesListView.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//

import SwiftUI

struct StoriesListView: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.stories) { story in
                    StoryView(story: story) {
                        viewModel.selectedStory = story
                    }
                    .onAppear {
                        Task {
                            await viewModel.loadMoreStoriesIfNeeded(currentItem: story)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
