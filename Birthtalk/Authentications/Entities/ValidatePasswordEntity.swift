import Foundation

struct ValidatePasswordEntity: AuthenticationErrorValidator {

    var error = AuthenticationError.invalidPassword
    private let password: String

    init(password: String) {
        self.password = password
    }

    func isValid() -> Bool {
        if password.characters.count < 5 { return false }
        return true
    }

}
