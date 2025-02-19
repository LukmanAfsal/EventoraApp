import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showValidationErrors: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                VideoPlayerView(videoName: "PartyMood1")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        VStack {
                            NavigationLink(destination: HomePageScreen()) {
                                Text("Skip")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.all, 12)
                                    .background(Rectangle().cornerRadius(25).foregroundStyle(Color.white.opacity(0.2)))
                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.purple))
                            }
                        }
                    }
                    .padding()

                    VStack {
                        Image("img-Eventora3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 270)
                        Text("Discover | Book | Experience")
                            .foregroundStyle(.white)
                    }
                    .padding(.top, 60)

                    Spacer()

                    // Login Form
                    VStack(spacing: 20) {
                        Text("Log in or sign up")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)

                        // Username Field
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.cgray)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(showValidationErrors && username.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )

                        // Password Field with Eye Icon
                        ZStack(alignment: .trailing) {
                            if showPassword {
                                TextField("Password", text: $password)
                            } else {
                                SecureField("Password", text: $password)
                            }
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 10)
                            }
                        }
                        .padding()
                        .background(Color.cgray)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(showValidationErrors && password.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                .padding(.horizontal, 20)
                        )

                        Button(action: {
                            if username.isEmpty || password.isEmpty {
                                showValidationErrors = true
                            } else {
                                print("Login button tapped")
                            }
                        }) {
                            Text("Login")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .cornerRadius(8)
                                .padding(.horizontal, 20)
                        }

                        HStack {
                            Text("Don't Have an Account?")
                                .foregroundStyle(Color.white)
                            NavigationLink(destination: SignUpPage()) {
                                Text("Sign Up")
                                    .foregroundStyle(Color.purple)
                                    .underline()
                            }
                        }
                    }

                    Spacer()

                    VStack(spacing: 10) {
                        Text("By continuing, you agree to our")
                            .foregroundStyle(.white)

                        HStack {
                            NavigationLink(destination: TermsOfService()) {
                                Text("Terms of Service")
                                    .underline()
                                    .foregroundStyle(.white)
                            }

                            Text("|")
                                .foregroundStyle(.white)

                            NavigationLink(destination: PrivacyPolicy()) {
                                Text("Privacy Policy")
                                    .underline()
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    LoginScreen()
}
