//
//  ExperienceCard.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//

import Foundation
import SwiftUI

struct ExperienceCard: View {
    let experience: Experience
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                // Background Image
                CoverImage(imageUrl: experience.coverPhoto, isImageLoaded: $viewModel.isImageLoaded)

                // Show overlays only when image is loaded
                if viewModel.isImageLoaded {
                    // Top-left: Recommended
                    if experience.recommended == 1 {
                        VStack {
                            HStack{
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color(hex: "F18757"))
                                    .frame(width: 8, height: 8)
                                Text("RECOMMENDED")
                                    .font(.custom("GothamMedium", size: 8))
                            }
                            .padding(5)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Top-right: Info Icon
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
                    
                    // Bottom-left: Views count
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

                    // Bottom-right: Album Icon
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

                    // Center: 360 Icon
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

            // Title and Likes
            HStack {
                Text(experience.title)
                    .font(.custom("Gotham-Bold", size: 14))
                    .lineLimit(1)
                    .truncationMode(.tail)

                Spacer()

                HStack {
                    Text("\(experience.likesNo)")
                        .font(.custom("GothamMedium", size: 14))
                    Image(systemName: viewModel.likedExperiences[experience.id] == true ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.likedExperiences[experience.id] == true ? Color(hex: "#F18757") : .gray)
                        .onTapGesture {
                            // Call the like function to toggle like state
                            // viewModel.likeExperience(experience: experience)
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
    }
}
