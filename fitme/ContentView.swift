//
//  ContentView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 30/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            // --- Heading ---
            HStack {
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: 125))
                    .font(.system(size: 28))
                
                Text("FitMe")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                AvatarView(initials: "CY")
                    .accessibilityLabel("Profile")
            }
            .padding(.horizontal)
            .background(Color(.systemBackground))
            
            // --- Body ---
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back,")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Text("User")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            Spacer() // Pushes content up and TabView down
            
            // --- Bottom Navigation ---
            TabView {
                Text("Home Content")
                    .tabItem { Label("Home", systemImage: "house") }
                
                Text("Workouts Content")
                    .tabItem { Label("Workouts", systemImage: "dumbbell") }
                
                Text("Exercises Content")
                    .tabItem { Label("Exercises", systemImage: "book") }
                
                Text("Progress Content")
                    .tabItem { Label("Progress", systemImage: "chart.line.uptrend.xyaxis") }
                
                Text("Account Content")
                    .tabItem { Label("Account", systemImage: "person") }
            }
            .frame(height: 100) // Note: Usually TabView is the root view, see below
        }
    }
}


struct AvatarView: View {
    var initials: String
    var image: Image? = nil
    var size: CGFloat = 44

    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.15))
                Text(initials)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.secondary.opacity(0.3), lineWidth: 1)
        )
        .contentShape(Circle())
    }
}

#Preview {
    ContentView()
}
