//
//  RetryErrorOverlayView.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 29/08/2025.
//
import SwiftUI

struct RetryErrorOverlayView: UIViewRepresentable {
    let message: String
    let retry: () -> Void
    let dismiss: () -> Void
    
    func makeUIView(context: Context) -> RetryErrorOverlay {
        let overlay = RetryErrorOverlay()
        return overlay
    }
    
    func updateUIView(_ uiView: RetryErrorOverlay, context: Context) {
        uiView.configure(message: message, retry: retry, dismiss: dismiss)
    }
}
