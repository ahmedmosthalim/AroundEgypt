//
//  HomeView.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var diContainer: AppDIContainer
    
    
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if isSearching {
                    SearchResultsView(viewModel: viewModel)
                } else {
                    MainContentView(viewModel: viewModel)
                }
            }
            .loading(viewModel.isLoading)
            .onReceive(NotificationCenter.default.publisher(for: .experienceLikeStatusChanged)) { notification in
                Task { await
                    viewModel.fetchHome()
                }
            }
            .retryErrorOverlay(message: $viewModel.error) {
                Task { await viewModel.fetchHome() }
            }
            .onAppear {
                Task { await
                    viewModel.fetchHome()
                }
            }
            .toolbar {
                toolbarContent
            }
        }
    }
}

struct MainContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var diContainer: AppDIContainer
    @State private var selectedExperience: Experience?
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                // Welcome Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome!")
                        .font(.custom("GothamRounded-Bold", size: 22))
                    Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                        .font(.custom("GothamMedium", size: 14))
                }
                // Recommended Experiences Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Recommended Experiences")
                        .font(.custom("Gotham-Bold", size: 22))
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.recommendedExperiences) { experience in
                                ExperienceCard(experience: experience, viewModel: viewModel)
                                    .frame(width: UIScreen.main.bounds.width * 0.9).onTapGesture {
                                        selectedExperience = experience
                                        viewModel.isSheetPresented = true
                                    }
                            }
                        }
                    }
                }
                
                // Most Recent Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Most Recent")
                        .font(.custom("Gotham-Bold", size: 22))
                        .padding(.horizontal)
                    VStack(spacing: 15) {
                        ForEach(viewModel.recentExperiences) { experience in
                            RecentExperienceCard(experience: experience, viewModel: viewModel)
                                .frame(width: UIScreen.main.bounds.width * 0.9).onTapGesture {
                                    // Set selected experience and present the sheet
                                    print("Tapped on experience: \(experience.title)")
                                    selectedExperience = experience
                                    viewModel.isSheetPresented = true
                                }
                        }
                    }
                }
            }
        }.refreshable {
            await viewModel.fetchHome()
        }
        .sheet(isPresented: $viewModel.isSheetPresented) {
            if let experience = selectedExperience {
                diContainer.makeDetailsView(id: experience.id)
            } else {
                // Fallback view if no experience is selected
                Text("No experience selected")
            }
        }
        .padding(.horizontal)
    }
}
