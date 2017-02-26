import XCTest
import Firebase
import FirebaseAuth
import FirebaseDatabase
@testable import Birthtalk

private var isFireAppConfigurated = false

class AuthenticationGatewayFirebaseTests: XCTestCase {

    private let userEmail = "fake@gmail.com"
    private let userName = "Name"
    private let userBirthdate = Date()
    private let userPassword = "somepassword"
    private var firAuth: FIRAuth = {
        if FIRApp.defaultApp() == nil { FIRApp.configure() }
        return FIRAuth.auth()!
    }()
    private var gateway: AuthenticationGateway!

    override func setUp() {
        super.setUp()
        gateway = AuthenticationGatewayFirebase(firAuth: firAuth)
    }

    override func tearDown() {
        super.tearDown()
        deleteCurrentUser()
    }

    private func deleteCurrentUser() {
        guard let firAuthCurrentUser = firAuth.currentUser else { return }
        let reference = FIRDatabase.database().reference(fromURL: "http://birthtalk-e14dd.firebaseio.com")
        let userReference = reference.child("users").child(firAuthCurrentUser.uid)

        userReference.removeValue()
        firAuthCurrentUser.delete { error in
            guard let error = error else { return }
            fatalError(error.localizedDescription)
        }
    }

    func testRegisterNewUserAtFirebaseReturnTheUserTroughtResultHandler() {
        let longRunningExpectation = expectation(description: "longRunningFunction")
        var authenticationError: AuthenticationError?
        var createdUser: UserEntity?

        gateway.register(name: userName, email: userEmail, password: userPassword, birthdate: userBirthdate) { result in
            switch result {
            case let .success(user): createdUser = user
            case let .failure(error): authenticationError = error
            }
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError)
            XCTAssertNil(authenticationError)
            XCTAssertNotNil(createdUser)
            XCTAssertEqual(self.userName, createdUser?.name)
            XCTAssertEqual(self.userEmail, createdUser?.email)
            XCTAssertEqual(self.userBirthdate, createdUser?.birthdate)
        }
    }

    func testRegisterUserWithAlreadyInUseEmailAtFirebaseReturnEmailAlreadyInUseErrorTroughtResultHandler() {
        let longRunningExpectation = expectation(description: "longRunningFunction")
        var authenticationError: AuthenticationError?
        var createdUser: UserEntity?
        gateway.register(name: userName, email: userEmail, password: userPassword, birthdate: userBirthdate) { _ in
            self.gateway.register(name: self.userName, email: self.userEmail, password: self.userPassword,
                                  birthdate: self.userBirthdate) { result in
                switch result {
                case let .success(user): createdUser = user
                case let .failure(error): authenticationError = error
                }
                longRunningExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError)
            XCTAssertNotNil(authenticationError)
            XCTAssertEqual(authenticationError, AuthenticationError.emailAlreadyInUse)
            XCTAssertNil(createdUser)
        }
    }

}
