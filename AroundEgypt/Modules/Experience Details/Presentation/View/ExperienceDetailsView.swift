//
//  ExperienceDetailsView.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import SwiftUI

public struct ExperienceDetailsView: View {
    @StateObject var viewModel: ExperienceDetailsViewModel
    @EnvironmentObject var diContainer: AppDIContainer
    
    @State private var isLiked: Bool = false
    @State private var isLoading: Bool = true
    var observer: NSObjectProtocol?
    
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomLeading) {
                    CoverImage(
                        imageUrl: viewModel.experience?.coverPhoto ?? "",
                        isImageLoaded: $viewModel.isImageLoaded,
                        width: UIScreen.main.bounds.width,
                        height: 300
                    )
                    HStack(spacing: 8) {
                        Image(systemName: "eye")
                        Text("\(viewModel.experience?.viewsNo ?? 0) views")
                            .font(.custom("GothamMedium", size: 14))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                
                Button(action: {
                    print("Explore Now tapped")
                }) {
                    Text("EXPLORE NOW")
                        .font(.custom("Gotham-Bold", size: 14))
                        .foregroundColor(.orange)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, -150)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(viewModel.experience?.title ?? "")
                            .font(.custom("Gotham-Bold", size: 16))
                            
                        Spacer()
                        
                        HStack(spacing: 8) {
                            ShareLink(item: viewModel.experience?.tourHtml ?? "") {
                                Label("Share Text", systemImage: "square.and.arrow.up")
                            }
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                            
                            Button(action: {
                                Task {
                                    await self.toggleLikeStatus()
                                }
                            }) {
                                Image(systemName: isLiked ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.orange)
                            }
                            
                            Text("\(viewModel.experience?.likesNo ?? 0)")
                                .font(.custom("Gotham-Bold", size: 14))
                                
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.custom("Gotham-Bold", size: 18))
                            
    
                        Text(viewModel.experience?.description ?? "")
                            .font(.custom("GothamMedium", size: 14))
                            
                            .lineSpacing(8)
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 16)
        }
        .onAppear {
            Task {
                 await viewModel.fetchExperienceByID(id: viewModel.experinceID ?? "")
                if (viewModel.likedExperiences.first(where: {$0.key == viewModel.experience?.id}) != nil) {
                    isLiked = true
                }
            }
            syncLikeState()
        }
        .onDisappear{
            if let observer = observer {
                NotificationCenter.default.removeObserver(observer)
            }
        }
        .navigationTitle("Experience Screen")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func syncLikeState() {
        isLiked = viewModel.likedExperiences[viewModel.experinceID ?? ""] ?? false
    }
    
    func toggleLikeStatus() async {
        if !isLiked {
            isLiked = true
            Task {
                await viewModel.likeAnExperince(id:viewModel.experinceID ?? "")
            }
        }
    }
}
