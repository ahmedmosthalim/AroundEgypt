//
//  RecentExperienceCard.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import SwiftUI

struct RecentExperienceCard: View {
    let experience: Experience
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                // Background Image
                CoverImage(imageUrl: experience.coverPhoto, isImageLoaded: $viewModel.isImageLoaded)
                
                if viewModel.isImageLoaded {
                    VStack {
                        Image("Shape Copy")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                            .padding(.top, 8)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    VStack {
                        Spacer()
                        HStack{
                            Image("Shape")
                            Text("\(experience.viewsNo)")
                                .font(.custom("GothamMedium", size: 12))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .padding(.vertical,8)
                            Spacer()
                        }.padding(.horizontal)
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("multiple pictures")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                                .padding(8)
                        }
                    }
                    
                    VStack {
                        Spacer()
                        Image("360")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.6)))
                            .padding()
                        Spacer()
                    }
                }
            }
            
            HStack {
                if viewModel.isImageLoaded {
                    Text(experience.title)
                        .font(.custom("Gotham-Bold", size: 14))
                        .lineLimit(1)
                        .truncationMode(.tail)
                } else {
                    // Shimmer for title
                    ShimmerView()
                        .frame(width: 150, height: 16)
                        .cornerRadius(4)
                }
                
                Spacer()
                
                if viewModel.isImageLoaded {
                    HStack {
                        Text("\(experience.likesNo)")
                            .font(.custom("GothamMedium", size: 14))
                        Image(systemName: viewModel.likedExperiences[experience.id] == true ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.likedExperiences[experience.id] == true ? Color(hex: "#F18757") : .gray)
                            .onTapGesture {
//                                 viewModel.likeExperience(experience: experience)
                            }
                    }
                } else {
                    ShimmerView()
                        .frame(width: 40, height: 16)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
}
