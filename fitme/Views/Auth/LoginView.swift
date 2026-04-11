import SwiftUI
import Supabase

struct LoginView: View {
    @Binding var isAuthenticated: Bool
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    enum Field: Hashable {
        case email
        case password
    }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                loginCardSection
                signUpSection
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: {
                    focusedField = .email
                }) {
                    Image(systemName: "chevron.up")
                }
                .disabled(focusedField == .email || focusedField == nil)
                
                Button(action: {
                    focusedField = .password
                }) {
                    Image(systemName: "chevron.down")
                }
                .disabled(focusedField == .password || focusedField == nil)
                
                Spacer()
                
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "dumbbell.fill")
                    .rotationEffect(Angle(degrees: 125))
                    .font(.system(size: 28))
                Text("FitMe")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Welcome! Let's get moving together")
                .foregroundStyle(.secondary)
        }
    }
    
    private var loginCardSection: some View {
        VStack(spacing: 16) {
            Text("Sign In")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            googleSignInButton

            separatorView

            emailField
            passwordField
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Text("Forgot Password?")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(Color.emerald)
                .frame(maxWidth: .infinity, alignment: .trailing)

            Button(action: {
                login()
            }) {
                Text("Sign In with E-mail")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .buttonStyle(.glassProminent)
            .frame(maxWidth: .infinity)
            .tint(Color.emerald)
            .disabled(!isLoginValid())
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal)
    }
    
    private var signUpSection: some View {
        HStack {
            Text("Don't have an account?")
                .foregroundStyle(.secondary)
            NavigationLink ( destination: SignUpView()){
                Text("Sign Up")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.emerald)
            }
        }
        .font(.footnote)
    }
    
    private var googleSignInButton: some View {
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
        .tint(Color.emerald)
    }
    
    private var separatorView: some View {
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
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("Enter your E-mail", text: $email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit { focusedField = .password }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var passwordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Password")
                .font(.caption)
                .foregroundStyle(.secondary)
            SecureField("Enter your Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
                .onSubmit {
                    if isLoginValid() {
                        login()
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    
    func isLoginValid() -> Bool {
        return !email.isEmpty && email.contains("@") && password.count >= 6
    }
}

#Preview {
    LoginView(isAuthenticated: .constant(false) )
}

