import SwiftUI
import SwiftUICore

struct LoginScreen: View {
    @StateObject private var viewModel = LogInViewModel()
    @State private var showPassword: Bool = false
    @State private var showValidationErrors: Bool = false
    
    @Binding var skippedOnboarding: Bool
    @Binding var loginSuccessful: Bool
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            ZStack {
                // MARK: - Background Video
                VideoPlayerView(videoName: "PartyMood1")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // MARK: - Skip Button
                    HStack {
                        Spacer()
                        VStack {
                            SkipButton()
                                .onTapGesture {
                                    skippedOnboarding = true
                                }
                        }
                        .padding()
                    }
                    
                    // MARK: - Logo and Tagline
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
                    
                    VStack(spacing: 20) {
                        // MARK: - Login Title
                        Text("Log in or sign up")
                            .bold()
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        // MARK: - Email TextField with Error Message
                        VStack(alignment: .leading, spacing: 4) {
                            TextField(text: $viewModel.email) {
                                Text("Enter your email")
                                    .foregroundStyle(.gray.opacity(0.5))
                            }
                            .frame(height: 20)
                            .padding()
                            .background(Color.cgray)
                            .foregroundStyle(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .textContentType(.emailAddress)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(showValidationErrors && viewModel.email.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            
                            if showValidationErrors && viewModel.email.isEmpty {
                                Text("Email is required")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal, 20)
                            }
                        }
                        
                        // MARK: - Password SecureField with Error Message
                        VStack(alignment: .leading, spacing: 4) {
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField(text: $viewModel.password) {
                                        Text("Password")
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                } else {
                                    SecureField(text: $viewModel.password) {
                                        Text("Password")
                                            .foregroundStyle(.gray.opacity(0.5))
                                    }
                                }
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(.white)
                                        .padding(.trailing, 10)
                                }
                            }
                            .frame(height: 20)
                            .padding()
                            .background(Color.cgray)
                            .cornerRadius(8)
                            .padding(.horizontal, 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(showValidationErrors && viewModel.password.isEmpty ? Color.red : Color.purple, lineWidth: 1)
                                    .padding(.horizontal, 20)
                            )
                            
                            if showValidationErrors && viewModel.password.isEmpty {
                                Text("Password is required")
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal, 20)
                            }
                        }
                        
                        // MARK: - General Error Message (if any)
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.horizontal, 20)
                        }
                        
                        // MARK: - Login Button
                        Button(action: {
                            if viewModel.email.isEmpty || viewModel.password.isEmpty {
                                showValidationErrors = true
                            } else {
                                Task {
                                    await viewModel.login() // Call the login function
                                }
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
                        .onChange(of: viewModel.isLogInSuccess) { _, _ in
                            loginSuccessful = true
                            router.navigateToRoot()
                        }
                        
                        // MARK: - Google Sign-In Button
                        Button(action: {
                            Task {
                                await viewModel.signInWithGoogle()
                            }
                        }) {
                            HStack {
                                Image("goog")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("Sign in with Google")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(28)
                            .padding(.horizontal, 20)
                        }
                        
                        // MARK: - Sign Up Link
                        HStack {
                            Text("Don't Have an Account?")
                                .foregroundStyle(Color.white)
                            Button(action: {
                                router.navigate(to: .signUp)
                            }) {
                                Text("Sign Up")
                                    .foregroundStyle(Color.purple)
                                    .fontWeight(.semibold)
                                    .underline()
                            }
                        }
                        
                        // MARK: - Forgot Password Button
                        HStack {
                            NavigationLink(destination: ForgotPassPage()) {
                                Text("Forgot Password?")
                                    .foregroundStyle(Color.purple)
                                    .underline()
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: - Terms and Privacy Policy
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
        .environmentObject(router)
    }
}

// MARK: - Preview
#Preview {
    LoginScreen(skippedOnboarding: .constant(false), loginSuccessful: .constant(false))
        .environmentObject(Router())
}
