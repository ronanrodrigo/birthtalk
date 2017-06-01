import Foundation

struct ValidateNameEntity: AuthenticationErrorValidator {

    var error = AuthenticationError.invalidName
    private let name: String

    init(name: String) {
        self.name = name
    }

    func isValid() -> Bool {
        if name.isEmpty {
            return false
        }
        return true
    }

}
