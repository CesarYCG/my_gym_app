//
//  ContentView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 30/01/26.
//

import SwiftUI
import Supabase

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
        } // Just A quick try for settup of DB
        .onAppear {
            Task {
                do {
                    // Test fetch to the "User" table
                    let response = try await supabase
                        .from("User")
                        .select()
                        .execute()
                    
                    if let stringData = String(data: response.data, encoding: .utf8) {
                        print("✅ Supabase Connection Successful!")
                        print("Data in 'User': \(stringData)")
                    }
                } catch {
                    print("❌ Supabase Connection Failed:")
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
