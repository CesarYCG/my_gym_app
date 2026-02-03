//
//  ContentView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 30/01/26.
//

import SwiftUI
import SwiftUI

struct ContentView: View {
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

            // You can add ExercisesView, ProgressView, etc., here similarly
            Text("Progress Screen")
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}
