//
//  SearchResultsView.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation
import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var diContainer: AppDIContainer
    @State private var selectedExperience: Experience? // Track the selected experience

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(viewModel.searchResults) { experience in
                    ExperienceCard(experience: experience, viewModel: viewModel)
                        .padding(.horizontal).onTapGesture {
                            // Set selected experience and present the sheet
                            print("Tapped on experience: \(experience.title)")
                            selectedExperience = experience
                        }

                }
            }
            .padding(.top, 8)
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            diContainer.makeDetailsView(id: selectedExperience?.id ?? "")
        }
    }
}
