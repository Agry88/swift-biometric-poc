import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State var isUnlocked = false
    @State var isNoBiometricFound = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your passwords."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                success, authenticationError in
               DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    }
                    else {
                        self.isUnlocked = false
                    }
                }
            }
        }

        else {
            self.isNoBiometricFound = true
        }
    }
    
    var body: some View {
        Button("Start", action: authenticate)
        if isUnlocked {
            VStack {
                Text("Hello User!")
            }
        }
        else {
            Text("Use your biometrics to use the app.")
        }
        if isNoBiometricFound {
            Text("No BiometricFound")
        }
    }
}




