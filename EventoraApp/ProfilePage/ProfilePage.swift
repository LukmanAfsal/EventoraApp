//
//  ProfilePage.swift
//  EventoraApp
//
//  Created by Abhinand K J on 14/02/25.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore

struct ProfilePage: View {
    @StateObject private var viewModel = ProfilePageViewModel()
    @EnvironmentObject private var router: Router
    @AppStorage("skippedOnboarding") var skippedOnboarding: Bool = false
    @AppStorage("isloggedin") var isLoggedIn: Bool = false
    
    @State private var profileImage: UIImage?
    @State private var showImagePicker = false
    @State private var dateOfBirth: Date = Date() // Initialize with a default value
    
    @State private var showLogoutConfirmation = false
    @State private var showDeleteAccountConfirmation = false
    
    var body: some View {
        ZStack {
            BackgroundRadient(gradientColor: .cpurple)
            
            if viewModel.isUserLoggedIn {
                ScrollView {
                    VStack(spacing: 20) {
                        // Profile Image Section
                        VStack(spacing: 10) {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            } else if let profilePictureURL = viewModel.userData?.profilePicture, let url = URL(string: profilePictureURL) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.gray)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 3))
                            }
                            
                            Button(action: { showImagePicker = true }) {
                                HStack {
                                    Image(systemName: "photo")
                                    Text("Change Photo")
                                }
                                .foregroundColor(.blue)
                                .font(.subheadline)
                            }
                        }
                        .padding(.top, 20)
                        
                        // User Details Section
                        VStack(spacing: 16) {
                            Section(header: Text("Personal Information")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)) {
                                    HStack {
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.gray)
                                        TextField("Name", text: .constant(viewModel.userData?.name ?? ""))
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    
                                    HStack {
                                        Image(systemName: "envelope.fill")
                                            .foregroundColor(.gray)
                                        TextField("Email", text: .constant(viewModel.userData?.email ?? ""))
                                            .disabled(true)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    
                                    HStack {
                                        Image(systemName: "calendar")
                                            .foregroundColor(.gray)
                                        DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                                            .onChange(of: dateOfBirth) { newValue in
                                                print("Date of Birth changed to: \(newValue)")
                                                viewModel.saveDateOfBirth(newValue)
                                            }
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                        }
                        .padding(.horizontal)
                        
                        // Actions Section
                        VStack(spacing: 16) {
                            Section(header: Text("Account Actions")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)) {
                                    Button(action: { showLogoutConfirmation = true }) {
                                        HStack {
                                            Image(systemName: "arrow.left.circle.fill")
                                                .foregroundColor(.white)
                                            Text("Log Out")
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.red)
                                        .cornerRadius(10)
                                    }
                                    
                                    Button(action: { showDeleteAccountConfirmation = true }) {
                                        HStack {
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(.white)
                                            Text("Delete Account")
                                                .foregroundColor(.white)
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.red.opacity(0.7))
                                        .cornerRadius(10)
                                    }
                                }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                }
            } else {
                LoginScreen2()
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .onAppear {
            viewModel.checkUserLoggedIn()
        }
        .onChange(of: viewModel.userData) { newUserData in
            if let savedDateOfBirth = newUserData?.dateOfBirth {
                dateOfBirth = savedDateOfBirth
            }
        }
        .onChange(of: viewModel.userLoggedOut) { _ in
            skippedOnboarding = false
            isLoggedIn = false
            router.navigateToRoot()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $profileImage)
        }
        .alert("Log Out", isPresented: $showLogoutConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Log Out", role: .destructive) {
                Task {
                    do {
                        try viewModel.signOut()
                    } catch {
                        print(error)
                    }
                }
            }
        } message: {
            Text("Are you sure you want to log out?")
        }
        .alert("Delete Account", isPresented: $showDeleteAccountConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                Task {
                    await viewModel.deleteAccount()
                }
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
    }
}

// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ProfilePage()
    // .environmentObject(Router())
}
