import SwiftUI
import Supabase

struct ContentView: View {
    // Listeners for Supabase Auth
    @State private var isAuthenticated = false 
    @State private var isCheckingSession = true
    
    var body: some View {
        Group {
            if isCheckingSession {
                // Loading screen while checking the token
                ProgressView("Connecting...")
            } else if isAuthenticated {
                // If user is logged in, show the main tab view
                MainTabView() 
            } else {
                // Else, go to sign in
                NavigationStack {
                    LoginView(isAuthenticated: $isAuthenticated)
                }
            }
        }
        .onAppear {
            checkCurrentSession()
        }
    }
    
    func checkCurrentSession() {
        Task {
            // Check if there is an active session in Supabase
            do {
                _ = try await supabase.auth.session
                isAuthenticated = true
            } catch {
                isAuthenticated = false
            }
            isCheckingSession = false
        }
    }
}
