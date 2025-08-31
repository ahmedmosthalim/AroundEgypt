//
//  HomeView+Search.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 31/08/2025.
//

import Foundation
import SwiftUI

extension HomeView {
    
    
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                print("Menu tapped")
            }) {
                Image("Menu")
            }
        }
        ToolbarItem(placement: .principal) {
            searchBar
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                print("Settings tapped")
            }) {
                Image("Object")
                    .font(.title2)
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image("Search")
            TextField("", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(Color(hex: "8E8E93"))
                .submitLabel(.search)
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        isSearching = false
                        Task { await
                            viewModel.fetchHome()
                        }
                    }
                }
                .onSubmit {
                    if searchText.isEmpty {
                        isSearching = false
                        Task { await
                            viewModel.fetchHome()
                        }
                    } else {
                        isSearching = true
                        Task { await
                            viewModel.fetchByTitle(title: searchText)
                        }
                    }
                }
                .placeholder(when: searchText.isEmpty) {
                    Text("Try \"Luxor\"")
                        .foregroundColor(Color(hex: "8E8E93"))
                        .font(.custom("GothamMedium", size: 14))
                }
        }
        .padding(.horizontal)
        .frame(height: 36)
        .cornerRadius(8)
    }
}
