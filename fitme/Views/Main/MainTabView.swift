//
//  ContentView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 30/01/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            WorkoutsView()
                .tabItem {
                    Label("Workouts", systemImage: "dumbbell")
                }
            
            UserProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}

#Preview {
    MainTabView()
}
