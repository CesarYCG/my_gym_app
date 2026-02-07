//
//  HomeView.swift
//  fitme
//
//  Created by César Yair Calderón Guevara on 02/02/26.
//

import SwiftUI


struct HomeView: View {
    
    private func startWorkout() {
        // TODO: Define this workout function
        print("Workout started")
    }
    
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
            
            // 2x2 Grid of main metrics
            VStack(){
                HStack(){
                    VStack(){
                        Image(systemName: "flame")
                        Text("Calories Burned")
                        Text("300 cal")
                    }
                    VStack(){
                        Image(systemName: "figure.strengthtraining.traditional")
                        Text("Finished Workouts")
                        Text("24")
                    }
                }
                HStack(){
                    VStack(){
                        Image(systemName: "timer")
                        Text("Total Time")
                        Text("12h")
                    }
                    VStack(){
                        Image(systemName: "trophy")
                        Text("Achievements")
                        Text("12")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal, .bottom])
            
            // Today's workout
            VStack(alignment: .leading){
                Text("Today's Workout:")
                    .font(.headline)
                    .padding([.top, .leading])
                Text("Workout Name - [#min] min")
                    .font(.body)
                    .padding(.horizontal)
                Button(action: startWorkout){
                    Label("Start Workout", systemImage:"play.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundStyle(.black)
                .controlSize(.large)
                .padding([.leading, .bottom])
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.emerald)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal)

            
            
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

#Preview {
    HomeView()
}
