import Foundation
import Observation

@MainActor
@Observable
class AuthenticationViewModel {

    var email = ""
    var password = ""

    var isAuthenticated = false
    var showManualLogin = false
    var errorMessage = ""

    private let biometricService = BiometricAuthService()

    func authenticateWithFaceID() async {

        do {
            let success = try await biometricService.authenticate()

            if success {
                isAuthenticated = true
            }

        } catch {
            showManualLogin = true
            errorMessage = "Face ID unavailable. Please login manually."
        }
    }

    func manualLogin() {

        errorMessage = ""

        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your email"
            return
        }

        if !email.contains("@") || !email.contains(".") {
            errorMessage = "Please enter a valid email"
            return
        }

        if password.isEmpty {
            errorMessage = "Please enter your password"
            return
        }

        if password.count < 6 {
            errorMessage = "Password must contain at least 6 characters"
            return
        }

        // Demo login credentials
        if email.lowercased() == "admin@gmail.com" &&
            password == "123456" {

            isAuthenticated = true

        } else {
            errorMessage = "Invalid email or password"
        }
    }
}
