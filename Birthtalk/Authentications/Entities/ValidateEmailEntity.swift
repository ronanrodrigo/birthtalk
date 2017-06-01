import Foundation

struct ValidateEmailEntity: AuthenticationErrorValidator {

    var error = AuthenticationError.invalidEmail
    private let email: String

    init(email: String) {
        self.email = email
    }

    func isValid() -> Bool {
        if email.isEmpty {
            return false
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: email)
    }

}
