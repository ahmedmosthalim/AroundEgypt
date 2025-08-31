//
//  ShareButton.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import SwiftUI

import SwiftUI

struct ShareButton: View {
    let tourUrl: URL
    
    var body: some View {
        Button(action: shareContent) {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.orange)
        }
    }
    
    private func shareContent() {
        print("Share tapped")
        
        // Share the URL directly (users can open it in browser)
        let activityViewController = UIActivityViewController(
            activityItems: [tourUrl],
            applicationActivities: nil
        )
        
        // Present the share sheet
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            
            // For iPad support
            if UIDevice.current.userInterfaceIdiom == .pad {
                activityViewController.popoverPresentationController?.sourceView = rootViewController.view
                activityViewController.popoverPresentationController?.sourceRect = CGRect(
                    x: rootViewController.view.bounds.midX,
                    y: rootViewController.view.bounds.midY,
                    width: 0, height: 0
                )
                activityViewController.popoverPresentationController?.permittedArrowDirections = []
            }
            
            rootViewController.present(activityViewController, animated: true)
        }
    }
}

// Alternative: Download and share as local file
struct ShareDownloadButton: View {
    let tourUrl: URL
    @State private var isDownloading = false
    
    var body: some View {
        Button(action: downloadAndShare) {
            if isDownloading {
                ProgressView()
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.orange)
            }
        }
    }
    
    private func downloadAndShare() {
        print("Download and share tapped")
        isDownloading = true
        
        // Download the file first
        URLSession.shared.dataTask(with: tourUrl) { data, response, error in
            DispatchQueue.main.async {
                isDownloading = false
                
                if let error = error {
                    print("Download failed: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                // Save to temporary directory
                let tempDirectory = FileManager.default.temporaryDirectory
                let fileName = tourUrl.lastPathComponent
                let fileURL = tempDirectory.appendingPathComponent(fileName)
                
                do {
                    try data.write(to: fileURL)
                    shareFile(fileURL: fileURL)
                } catch {
                    print("Failed to save file: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    private func shareFile(fileURL: URL) {
        let activityViewController = UIActivityViewController(
            activityItems: [fileURL],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                activityViewController.popoverPresentationController?.sourceView = rootViewController.view
                activityViewController.popoverPresentationController?.sourceRect = CGRect(
                    x: rootViewController.view.bounds.midX,
                    y: rootViewController.view.bounds.midY,
                    width: 0, height: 0
                )
                activityViewController.popoverPresentationController?.permittedArrowDirections = []
            }
            
            rootViewController.present(activityViewController, animated: true)
        }
    }
}

//// Usage example:
//struct ContentView: View {
//    let tourUrl = URL(string: "https://aroundegypt-production.s3.eu-central-1.amazonaws.com/1586027305vtour/vtour/tour.html")!
//    
//    var body: some View {
//        VStack {
//            // Simple URL sharing (recommended)
//            ShareButton(tourUrl: tourUrl)
//            
//            // Download and share as file (if you need the actual file)
//            ShareDownloadButton(tourUrl: tourUrl)
//        }
//    }
//}
