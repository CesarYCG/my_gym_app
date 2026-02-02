//
//  ContentView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 30/01/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(){
            HStack{
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: 125))
                    .font(.system(size: 28))
                    .padding(.leading)
                Text("FitMe")
                    .font(.title)
                    .foregroundColor(.black)
                Spacer()
                AvatarView(initials: "CY")
                    .accessibilityLabel("Profile")
                    .padding()
            }.background(Color(.systemGray6))
        
            Spacer()
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
