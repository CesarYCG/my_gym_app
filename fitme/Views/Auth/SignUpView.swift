import SwiftUI
import Supabase
import OSLog

struct SignUpView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateofBirth: Date = Date()
    @State private var selectedGender: String = "Other"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage = ""
    
    private let genders = ["Male", "Female", "Other"]
    
    private let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }()
    
    enum Field: Hashable {
        case firstName
        case lastName
        case email
        case password
        case confirmPassword
    }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                signUpCardSection
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(action: {
                    moveFocus(direction: -1)
                }) {
                    Image(systemName: "chevron.up")
                }
                .disabled(focusedField == .firstName || focusedField == nil)
                
                Button(action: {
                    moveFocus(direction: 1)
                }) {
                    Image(systemName: "chevron.down")
                }
                .disabled(focusedField == .confirmPassword || focusedField == nil)
                
                Spacer()
                
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
    
    private func moveFocus(direction: Int) {
        let fields: [Field] = [.firstName, .lastName, .email, .password, .confirmPassword]
        guard let current = focusedField, let currentIndex = fields.firstIndex(of: current) else { return }
        
        let newIndex = currentIndex + direction
        if newIndex >= 0 && newIndex < fields.count {
            focusedField = fields[newIndex]
        }
    }
    
    // MARK: - UI Components
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "person.badge.plus")
                    .font(.system(size: 28))
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()
            }
            Text("Join us and start your fitness journey")
                .foregroundStyle(.secondary)
        }
    }
    
    private var signUpCardSection: some View {
        VStack(spacing: 16) {
            Text("Sign Up")
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            firstNameField
            lastNameField
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Date of Birth")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                DatePicker("", selection: $dateofBirth, displayedComponents: .date)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Gender")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Picker("Gender", selection: $selectedGender) {
                    ForEach(genders, id: \.self) { gender in
                        Text(gender)
                    }
                }
                .pickerStyle(.segmented)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            emailField
            passwordField
            confirmPasswordField
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                signUp()
            }) {
                Text("Sign Up")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .buttonStyle(.glassProminent)
            .frame(maxWidth: .infinity)
            .tint(Color.emerald)
            .disabled(!isFormValid())
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

    private var firstNameField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("First Name")
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("Enter your first name", text: $firstName)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit { focusedField = .lastName }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var lastNameField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Last Name (Optional)")
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("Enter your last name", text: $lastName)
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .lastName)
                .submitLabel(.next)
                .onSubmit { focusedField = .email }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var emailField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email")
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField("Enter your email", text: $email)
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
            SecureField("Enter your password", text: $password)
                .textFieldStyle(.roundedBorder)
                .textContentType(.newPassword)
                .focused($focusedField, equals: .password)
                .submitLabel(.next)
                .onSubmit { focusedField = .confirmPassword }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var confirmPasswordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Confirm Password")
                .font(.caption)
                .foregroundStyle(.secondary)
            SecureField("Confirm your password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .textContentType(.newPassword)
                .focused($focusedField, equals: .confirmPassword)
                .submitLabel(.done)
                .onSubmit {
                    if isFormValid() {
                        signUp()
                    }
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Sign Up Logic
    func signUp() {
        Task {
            do {
                _ = try await supabase.auth.signUp(email: email, 
                                                password: password,
                                                data: [
                                                    "first_name": .string(firstName),
                                                    "last_name": .string(lastName),
                                                    "birth_date": .string(dateFormatter.string(from: dateofBirth)),
                                                    "gender": .string(selectedGender),
                                                    "email": .string(email),
                                                ]
                                            )
            } catch {
                os_log(.error, log: OSLog.default, "Sign up failed: %{public}s", error.localizedDescription)
            }
        }
    }

    // MARK: - Form Validation
    func isFormValid() -> Bool {
        guard !email.isEmpty, email.contains("@"), !password.isEmpty, !confirmPassword.isEmpty, !firstName.isEmpty else { return false }
        guard password == confirmPassword else { return false }
        guard password.count >= 6 else { return false }
        return true
    }
}

#Preview {
    SignUpView()
}

