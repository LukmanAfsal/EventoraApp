//
//  PrivacyPolicy.swift
//  EventoraApp
//
//  Created by Abhinand K J on 13/02/25.
//

import SwiftUI

// MARK: - PrivacyPolicy View
struct PrivacyPolicy: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: - Title
                Text("Privacy Policy for Eventora")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 8)
                
                // MARK: - Introduction
                Group {
                    Text("Thank you for choosing **Eventora**, your go-to app for booking and managing events. We are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy outlines how we collect, use, store, and protect your information when you use our app. By using **Eventora**, you agree to the terms outlined in this policy.")
                        .padding(.bottom, 8)
                }
                
                // MARK: - Information We Collect
                Group {
                    Text("1. Information We Collect")
                        .font(.title2)
                        .bold()
                    Text("We may collect the following types of information when you use **Eventora**:")
                    Text("- **Personal Information**: This includes your name, email address, phone number, and payment details when you create an account, book events, or make transactions.")
                    Text("- **Event Information**: Details about the events you book, such as event names, dates, locations, and preferences.")
                    Text("- **Device Information**: We may collect information about your device, including its unique identifier, operating system, and mobile network.")
                    Text("- **Usage Data**: Information about how you interact with the app, such as pages visited, features used, and time spent on the app.")
                    Text("- **Location Data**: If you enable location services, we may collect your precise or approximate location to provide event recommendations or facilitate bookings.")
                }
                
                // MARK: - How We Use Your Information
                Group {
                    Text("2. How We Use Your Information")
                        .font(.title2)
                        .bold()
                    Text("We use the information we collect for the following purposes:")
                    Text("- To provide, maintain, and improve our services, including event booking and management.")
                    Text("- To process transactions and send you confirmations, receipts, and updates.")
                    Text("- To personalize your experience by recommending events and features tailored to your preferences.")
                    Text("- To communicate with you about your account, bookings, promotions, and app updates.")
                    Text("- To ensure the security of our app and prevent fraud or unauthorized access.")
                    Text("- To comply with legal obligations and enforce our terms of service.")
                }
                
                // MARK: - Sharing Your Information
                Group {
                    Text("3. Sharing Your Information")
                        .font(.title2)
                        .bold()
                    Text("We do not sell or rent your personal information to third parties. However, we may share your information in the following circumstances:")
                    Text("- **Service Providers**: We may share your information with trusted third-party service providers who assist us in operating the app, processing payments, or delivering services.")
                    Text("- **Event Organizers**: If you book an event, we may share necessary details (e.g., your name and contact information) with the event organizer to facilitate your booking.")
                    Text("- **Legal Requirements**: We may disclose your information if required by law or to protect our rights, property, or safety, or that of others.")
                    Text("- **Business Transfers**: In the event of a merger, acquisition, or sale of assets, your information may be transferred to the new owner.")
                }
                
                // MARK: - Data Security
                Group {
                    Text("4. Data Security")
                        .font(.title2)
                        .bold()
                    Text("We take the security of your information seriously and implement industry-standard measures to protect it from unauthorized access, alteration, or destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.")
                }
                
                // MARK: - Your Rights and Choices
                Group {
                    Text("5. Your Rights and Choices")
                        .font(.title2)
                        .bold()
                    Text("You have the following rights regarding your personal information:")
                    Text("- **Access and Update**: You can access and update your account information through the app settings.")
                    Text("- **Delete Account**: You may request to delete your account and personal data by contacting us at [Insert Contact Email].")
                    Text("- **Opt-Out**: You can opt out of receiving promotional emails by following the unsubscribe link in the email.")
                    Text("- **Location Services**: You can enable or disable location services through your device settings.")
                }
                
                // MARK: - Children’s Privacy
                Group {
                    Text("6. Children’s Privacy")
                        .font(.title2)
                        .bold()
                    Text("**Eventora** is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children. If we become aware that we have collected such information, we will take steps to delete it promptly.")
                }
                
                // MARK: - Changes to This Privacy Policy
                Group {
                    Text("7. Changes to This Privacy Policy")
                        .font(.title2)
                        .bold()
                    Text("We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of any significant changes by posting the updated policy on our app or website. Your continued use of **Eventora** after such changes constitutes your acceptance of the updated policy.")
                }
                
                // MARK: - Contact Us
                Group {
                    Text("8. Contact Us")
                        .font(.title2)
                        .bold()
                    Text("If you have any questions, concerns, or requests regarding this Privacy Policy or your personal information, please contact us at:")
                    Text("**Email**: [Insert Contact Email]")
                    Text("**Address**: [Insert Company Address, if applicable]")
                }
                
                // MARK: - Closing Statement
                Text("Thank you for trusting **Eventora** with your event booking needs. We are dedicated to providing you with a seamless and secure experience.")
                    .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

// MARK: - Preview
#Preview {
    PrivacyPolicy()
}
