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

    private static let errorByCode: [Int: AuthenticationError] = [
        17005: .userDisabled,
        17007: .emailAlreadyInUse,
        17008: .invalidEmail,
        17009: .wrongPassword,
        17011: .userNotFound,
        17012: .accountExistsWithDifferentCredential,
        17020: .networkError,
        17025: .credentialAlreadyInUse,
        17026: .invalidPassword
    ]

    init(rawValue: Int) {
        self = AuthenticationError.errorByCode[rawValue] ?? .unknown
    }
}
