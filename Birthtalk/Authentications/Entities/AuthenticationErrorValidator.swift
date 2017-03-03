import Foundation

protocol AuthenticationErrorValidator {
    var error: AuthenticationError { get }
    func isValid() -> Bool
}
