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
                    Text("Sign In")
                        .font(.title3)
                        .bold()

                    Button(action: {
                        // TO DO - Replace with Google Auth
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "g.circle.fill")
                                .imageScale(.large)
                            Text("Sign In With Google")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.glassProminent)
                    .frame(maxWidth: .infinity)

                    // Separator with lines on both sides
                    HStack(alignment: .center, spacing: 8) {
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(minWidth: 24, maxWidth: .infinity)
                            .frame(height: 1)
                        Text("Or continue with")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .fixedSize(horizontal: true, vertical: false)
                        Rectangle()
                            .fill(Color.secondary.opacity(0.3))
                            .frame(minWidth: 24, maxWidth: .infinity)
                            .frame(height: 1)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("Enter your E-mail", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        SecureField("Enter your Password", text: $password)
                            .textFieldStyle(.roundedBorder)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Text("Forgot Password?")
                        .frame(maxWidth: .infinity, alignment: .trailing)

                    Button("Sign In") {
                        login()
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(20)
            }
            .padding(.horizontal)
            
            HStack{
                Text("Don't have an account?")
                Text("Sign Up")
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

