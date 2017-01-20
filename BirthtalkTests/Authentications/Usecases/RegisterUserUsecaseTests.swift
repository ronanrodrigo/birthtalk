import XCTest
@testable import Birthtalk

class RegisterUserUsecaseTests: XCTestCase {

    let empty = ""
    let smallPassword = "1234"
    let invalidEmail = "invalid"
    let validMail = "fake@mail.com"
    let validPassword = "somepassword"
    let validName = "Name"
    let validDate = Date()

    var usecase: RegisterUserUsecase!
    var presenter: RegisterUserPresenterStub!
    var gateway: AuthenticationGatewayStub!

    override func setUp() {
        gateway = AuthenticationGatewayStub()
        presenter = RegisterUserPresenterStub()
        usecase = RegisterUserUsecase(presenter: presenter, gateway: gateway)
    }

    func testRegisterAnUserWithEmptyEmailDisplayEmailErrorMessage() {
        usecase.register(name: validName, email: empty, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithInvalidEmailDisplayEmailErrorMessage() {
        usecase.register(name: validName, email: invalidEmail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyNameDisplayNameErrorMessage() {
        usecase.register(name: empty, email: validMail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyPasswordDisplayPasswordErrorMessage() {
        usecase.register(name: validName, email: validMail, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithoutAtLeastFiveCharactersInThePasswordDisplayPasswordErrorMessage() {
        usecase.register(name: validName, email: validMail, password: smallPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllEmptyInputDisplayAllErrorMessages() {
        usecase.register(name: empty, email: empty, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllInvalidInputDisplayAllErrorMessages() {
        usecase.register(name: empty, email: invalidEmail, password: smallPassword, birthdate: validDate)

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

    private func generateUserEntity() -> UserEntity {
        return UserEntity(identifier: nil, name: validName, email: validMail, password: validPassword,
                          birthdate: validDate)
    }

}
