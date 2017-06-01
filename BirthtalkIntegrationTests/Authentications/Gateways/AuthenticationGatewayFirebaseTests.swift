import XCTest
import Firebase
import FirebaseAuth
import FirebaseDatabase
@testable import Birthtalk

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
        let reference = FIRDatabase.database().reference(fromURL: Enviroment.firebaseDatabase.rawValue)
        let userReference = reference.child(DatabasePath.users.rawValue).child(firAuthCurrentUser.uid)

        userReference.removeValue()
        firAuthCurrentUser.delete { XCTAssertNil($0) }
    }

    func testRegisterNewUserAtFirebaseReturnTheUserTroughtResultHandler() {
        let longRunningExpectation = expectation(description: "RegisterNewUser")
        var authenticationError: AuthenticationError?
        var createdUser: UserEntity?

        let userParams = RegisterUserBasicParams(name: userName, email: userEmail, password: userPassword,
                                                 birthdate: userBirthdate)
        gateway.register(userParams: userParams) { result in
            switch result {
            case let .success(user): createdUser = user
            case let .failure(error): authenticationError = error
            }
            longRunningExpectation.fulfill()
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertNil(authenticationError)
            XCTAssertNotNil(createdUser)
            XCTAssertEqual(self.userName, createdUser?.name)
            XCTAssertEqual(self.userEmail, createdUser?.email)
            XCTAssertEqual(self.userBirthdate, createdUser?.birthdate)
        }
    }

    func testRegisterUserWithAlreadyInUseEmailAtFirebaseReturnEmailAlreadyInUseErrorTroughtResultHandler() {
        let longRunningExpectation = expectation(description: "RegisterUserWithAlreadyInUseEmail")
        var authenticationError: AuthenticationError?
        var createdUser: UserEntity?

        let userParams = RegisterUserBasicParams(name: userName, email: userEmail, password: userPassword,
                                                 birthdate: userBirthdate)
        gateway.register(userParams: userParams) { _ in
            self.gateway.register(userParams: userParams) { result in
                switch result {
                case let .success(user): createdUser = user
                case let .failure(error): authenticationError = error
                }
                longRunningExpectation.fulfill()
            }
        }

        waitForExpectations(timeout: 20) { expectationError in
            XCTAssertNil(expectationError, expectationError!.localizedDescription)
            XCTAssertNotNil(authenticationError)
            XCTAssertEqual(authenticationError, AuthenticationError.emailAlreadyInUse)
            XCTAssertNil(createdUser)
        }
    }

}
