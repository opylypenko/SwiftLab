//
//  StoryDetailView.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//

import SwiftUI

struct StoryDetailView: View {
    @ObservedObject var viewModel: FeedViewModel
    var initialIndex: Int
    
    var onClose: () -> Void
    
    @State var currentIndex: Int
    
    init(viewModel: FeedViewModel, initialIndex: Int, onClose: @escaping () -> Void) {
        self.viewModel = viewModel
        self.initialIndex = initialIndex
        self.onClose = onClose
        self._currentIndex = State(initialValue: initialIndex)
    }
    
    var body: some View {
        return AnyView(
            TabView(selection: $currentIndex) {
                ForEach(Array(viewModel.stories.enumerated()), id: \.element.id) { index, story in
                    
                    VStack(spacing: 20) {
                        Text("Story ID: \(story.id)")
                            .font(.largeTitle)
                        Text("\(story.author)")
                        
                        AsyncImage(url: URL(string: story.fullImageURL)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 400)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Button("Close") {
                            onClose()
                        }
                        .padding(.top)
                    }
                    .padding()
                    .tag(index)
                    .onAppear {
                        print("Current story: \(story)")
                        viewModel.markStoryAsRead(story)
                        Task {
                            await viewModel.loadMoreStoriesIfNeeded(currentItem: story)
                        }
                    }
                }
            }
                .tabViewStyle(.page(indexDisplayMode: .never))
        )
    }
}
