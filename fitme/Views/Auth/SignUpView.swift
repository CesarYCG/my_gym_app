import SwiftUI

struct SignUpView: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var dateofBirth: Date = Date()
    @State private var selectedGender: String = "Other"
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var email: String = ""
    @State private var errorMessage = ""
    
    private let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()

                    TextField("First Name", text: $firstName)

                    TextField("Last Name", text: $lastName)

                    DatePicker("Date of Birth", selection: $dateofBirth, displayedComponents: .date)

                    Picker("Gender", selection: $selectedGender){
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }

                    TextField("Email", text: $email)

                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)

                }
            }
        } 
    
    }

}

#Preview {
    SignUpView()
}
