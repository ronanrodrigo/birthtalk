import XCTest
@testable import Birthtalk

class RegisterUserUsecaseTests: XCTestCase {

    let empty = ""
    let smallPassword = "1234"
    let invalidEmail = "invalid"
    static let validMail = "fake@mail.com"
    static let validPassword = "somepassword"
    static let validName = "Name"
    static let validDate = Date()

    var usecase: RegisterUserUsecase!
    var presenter: RegisterUserPresenterStub!
    var gateway: AuthenticationGatewayStub!

    override func setUp() {
        gateway = AuthenticationGatewayStub()
        presenter = RegisterUserPresenterStub()
        usecase = RegisterUserUsecase(presenter: presenter, gateway: gateway)
    }

    func testRegisterAnUserWithEmptyEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: empty)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithInvalidEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: invalidEmail)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyNameDisplayNameErrorMessage() {
        let user = generateUserEntity(name: empty)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyPasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity(password: empty)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithoutAtLeastFiveCharactersInThePasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity(password: smallPassword)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllEmptyInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty, password: empty)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllInvalidInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty, password: smallPassword)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithValidInputSaveDataAndPresentSuccessMessage() {
        let user = generateUserEntity()
        gateway.registerResult = Result.success(user)

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

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

        usecase.register(name: user.name, email: user.email, password: user.password, birthdate: user.birthdate)

        XCTAssertTrue(presenter.showInvalidRequestErrorMessage)
        XCTAssertNil(gateway.registeredUser)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    private func generateUserEntity(name: String = validName, email: String = validMail,
                                    password: String = validPassword, birthdate: Date = validDate) -> UserEntity {
        return UserEntity(identifier: nil, name: name, email: email, password: password, birthdate: birthdate)
    }

}
