import Foundation
import LocalAuthentication

class BiometricAuthService {

    func authenticate() async throws -> Bool {

        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) else {
            throw error ?? LAError(.biometryNotAvailable)
        }

        let success = try await context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Authenticate to access your delivery log"
        )

        return success
    }

    func isBiometricAvailable() -> Bool {

        let context = LAContext()
        var error: NSError?

        return context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        )
    }
}
