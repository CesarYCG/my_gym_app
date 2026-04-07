import SwiftUI
import Supabase

struct LoginView: View {
    @Binding var isAuthenticated: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            HStack{
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: 125))
                    .font(.system(size: 28))
                Text("FitMe")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Welcome! Let's get moving together")
            
            ZStack {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                    )
                VStack(spacing: 16) {
                    Text("Sign Up")
                        .font(.title3)
                        .bold()

                    Button("Sign up With Google"){
                        // TO DO - Replace with Google Auth
                    }
                    .buttonStyle(.glassProminent)

                    // Separator with lines on both sides
                    HStack(alignment: .center, spacing: 8) {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(height: 1)
                        Text("Or continue with")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(height: 1)
                    }

                    TextField("E-mail", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button("Sign up") {
                        login()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(20)
            }
            .padding(.horizontal)
            
            HStack{
                Text("Already have an account?")
                Text("Sign in")
            }
            
        }
        .padding()
    }
    
    func login() {
        Task {
            do {
                // Call to SupabaseConfig
                try await supabase.auth.signIn(email: email, password: password)
                isAuthenticated = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    LoginView(isAuthenticated: .constant(false) )
}

