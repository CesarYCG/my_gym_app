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
                Spacer()
                AvatarView(initials: "CY")
                    .accessibilityLabel("Profile")
                    .padding()
            }.background(Color(.systemBackground))
            Spacer()
        }
        TabView{
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Workouts")
                .tabItem{
                    Label("Workouts", systemImage: "dumbbell")
                }
            Text("Excercises")
                .tabItem{
                    Label("Excercises", systemImage: "book")
                }
            Text("Progress")
                .tabItem{
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
            Text("Account")
                .tabItem{
                    Label("Account", systemImage: "person")
                }
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
