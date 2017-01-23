import XCTest
@testable import Birthtalk

class AuthenticationErrorTests: XCTestCase {

    func testInitAuthenticationErrorWith17005ReturnUserDisabledEnum() {
        let authenticationError = AuthenticationError(rawValue: 17005)

        XCTAssertEqual(AuthenticationError.userDisabled, authenticationError)
    }

    func testInitAuthenticationErrorWith17007ReturnEmailAlreadyInUseEnum() {
        let authenticationError = AuthenticationError(rawValue: 17007)

        XCTAssertEqual(AuthenticationError.emailAlreadyInUse, authenticationError)
    }

    func testInitAuthenticationErrorWith17008ReturnInvalidEmailEnum() {
        let authenticationError = AuthenticationError(rawValue: 17008)

        XCTAssertEqual(AuthenticationError.invalidEmail, authenticationError)
    }

    func testInitAuthenticationErrorWith17009ReturnWrongPasswordEnum() {
        let authenticationError = AuthenticationError(rawValue: 17009)

        XCTAssertEqual(AuthenticationError.wrongPassword, authenticationError)
    }

    func testInitAuthenticationErrorWith17011ReturnUserNotFoundEnum() {
        let authenticationError = AuthenticationError(rawValue: 17011)

        XCTAssertEqual(AuthenticationError.userNotFound, authenticationError)
    }

    func testInitAuthenticationErrorWith17012ReturnAccountExistsWithDifferentCredentialEnum() {
        let authenticationError = AuthenticationError(rawValue: 17012)

        XCTAssertEqual(AuthenticationError.accountExistsWithDifferentCredential, authenticationError)
    }

    func testInitAuthenticationErrorWith17020ReturnNetworkErrorEnum() {
        let authenticationError = AuthenticationError(rawValue: 17020)

        XCTAssertEqual(AuthenticationError.networkError, authenticationError)
    }

    func testInitAuthenticationErrorWith17025ReturnCredentialAlreadyInUseEnum() {
        let authenticationError = AuthenticationError(rawValue: 17025)

        XCTAssertEqual(AuthenticationError.credentialAlreadyInUse, authenticationError)
    }

    func testInitAuthenticationErrorWith17026ReturnInvalidPasswordEnum() {
        let authenticationError = AuthenticationError(rawValue: 17026)

        XCTAssertEqual(AuthenticationError.invalidPassword, authenticationError)
    }

    func testInitAuthenticationErrorWithAnyOtherNumberReturnUnknownEnum() {
        let authenticationError = AuthenticationError(rawValue: 9999)

        XCTAssertEqual(AuthenticationError.unknown, authenticationError)
    }

}
