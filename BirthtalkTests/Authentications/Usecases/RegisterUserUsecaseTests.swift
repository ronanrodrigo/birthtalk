import XCTest
@testable import Birthtalk

class RegisterUserUsecaseTests: XCTestCase {

    private let empty = ""
    private let smallPassword = "1234"
    private let invalidEmail = "invalid"
    private let validPassword = "somepassword"
    private static let validMail = "fake@mail.com"
    private static let validName = "Name"
    private static let validDate = Date()

    private var usecase: RegisterUserUsecase!
    private var presenter: RegisterUserPresenterStub!
    private var gateway: AuthenticationGatewayStub!

    override func setUp() {
        gateway = AuthenticationGatewayStub()
        presenter = RegisterUserPresenterStub()
        usecase = RegisterUserUsecase(presenter: presenter, gateway: gateway)
    }

    func testRegisterAnUserWithEmptyEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: empty)

        usecase.register(name: user.name, email: user.email, password: validPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithInvalidEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: invalidEmail)

        usecase.register(name: user.name, email: user.email, password: validPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyNameDisplayNameErrorMessage() {
        let user = generateUserEntity(name: empty)

        usecase.register(name: user.name, email: user.email, password: validPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyPasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity()

        usecase.register(name: user.name, email: user.email, password: empty, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithoutAtLeastFiveCharactersInThePasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity()

        usecase.register(name: user.name, email: user.email, password: smallPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllEmptyInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty)

        usecase.register(name: user.name, email: user.email, password: empty, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllInvalidInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty)

        usecase.register(name: user.name, email: user.email, password: smallPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithValidInputSaveDataAndPresentSuccessMessage() {
        let user = generateUserEntity()
        gateway.registerResult = Result.success(user)

        usecase.register(name: user.name, email: user.email, password: validPassword, birthdate: user.birthdate)

        XCTAssertNotNil(gateway.registeredUser)
        XCTAssertEqual(gateway.registeredUser!, user)
        XCTAssertTrue(presenter.shownRegistredUser)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWithGatewayErrorDisplayGatewayErrorMessage() {
        gateway.registerResult = Result.failure(RequestError.notConnectedToInternet)
        let user = generateUserEntity()

        usecase.register(name: user.name, email: user.email, password: validPassword, birthdate: user.birthdate)

        XCTAssertTrue(presenter.showInvalidRequestErrorMessage)
        XCTAssertNil(gateway.registeredUser)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    private func generateUserEntity(name: String = validName, email: String = validMail,
                                    birthdate: Date = validDate) -> UserEntity {
        return UserEntity(identifier: nil, name: name, email: email, birthdate: birthdate)
    }

}
