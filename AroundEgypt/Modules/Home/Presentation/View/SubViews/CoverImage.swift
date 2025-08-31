//
//  CoverImage.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation
import SwiftUI
import Network

struct CoverImage: View {
    var imageUrl: String
    @Binding var isImageLoaded: Bool
    private let networkMonitor: NetworkMonitorContract
    var width: CGFloat?
    var height: CGFloat?

    init(
        imageUrl: String,
        isImageLoaded: Binding<Bool>,
        width: CGFloat? = UIScreen.main.bounds.width * 0.9,
        height: CGFloat? = 200,
        networkMonitor: NetworkMonitorContract = NetworkMonitor()
    ) {
        self.imageUrl = imageUrl
        self._isImageLoaded = isImageLoaded
        self.width = width ??  UIScreen.main.bounds.width * 0.9
        self.height = height ??  200
        self.networkMonitor = networkMonitor
    }
    var body: some View {
        ZStack {
            if networkMonitor.isConnected{
                AsyncImage(url: URL(string: imageUrl)) { phase in
                    Group {
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: height)
                                .clipped()
                                .cornerRadius(8)
                                .onAppear {
                                    withAnimation {
                                        isImageLoaded = true
                                    }
                                }
                        } else if phase.error != nil {
                            Color.gray
                                .frame(width: width, height: height)
                                .cornerRadius(8)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                )
                        } else {
                            ShimmerView()
                                .frame(width: width, height: height)
                                .cornerRadius(8)
                        }
                    }
                }
            } else {
                // Offline state - show placeholder or cached image
                Color.gray
                    .frame(width: width, height: height)
                    .cornerRadius(8)
                    .overlay(
                        Image(systemName: "wifi.slash")
                            .foregroundColor(.white)
                    )
            }
        }
    }
}
