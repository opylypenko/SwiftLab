//
//  FeedView.swift
//  MiniInstagram
//
//  Created by Oleksandr Pylypenko on 16.07.2025.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel

    var body: some View {
        VStack {
            StoriesListView(viewModel: viewModel)
                .frame(height: 110)
            Spacer()
        }
        .onAppear {
            viewModel.loadInitialData()
        }
    }
}
