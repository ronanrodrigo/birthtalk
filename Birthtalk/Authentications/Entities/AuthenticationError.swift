enum AuthenticationError: Error {
    case invalidName
    case invalidPassword
    case userDisabled
    case emailAlreadyInUse
    case invalidEmail
    case wrongPassword
    case userNotFound
    case accountExistsWithDifferentCredential
    case networkError
    case credentialAlreadyInUse
    case unknown

    static func requestError(of raw: Int) -> AuthenticationError {
        switch raw {
        case 17005: return .userDisabled
        case 17007: return .emailAlreadyInUse
        case 17008: return .invalidEmail
        case 17009: return .wrongPassword
        case 17011: return .userNotFound
        case 17012: return .accountExistsWithDifferentCredential
        case 17020: return .networkError
        case 17025: return .credentialAlreadyInUse
        case 17026: return .invalidPassword
        default: return .unknown
        }
    }
}
