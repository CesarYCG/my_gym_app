//
//  HomeView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 02/02/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: 125))
                    .font(.system(size: 28))
                Text("FitMe").font(.title).bold()
                Spacer()
                AvatarView(initials: "CY")
            }
            .padding(.horizontal)
            
            // Welcome Section
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back,")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                Text("User")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            Spacer() // Pushes everything to the top
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
