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

    override func setUp() {
        presenter = RegisterUserPresenterStub()
        usecase = RegisterUserUsecase(presenter: presenter)
    }

    // MARK: - Validate inputs tests

    func testRegisterAnUserWithEmptyEmailDisplayEmailErrorMessage() {
        usecase.register(name: validName, email: empty, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testRegisterAnUserWithInvalidEmailDisplayEmailErrorMessage() {
        usecase.register(name: validName, email: invalidEmail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testRegisterAnUserWithEmptyNameDisplayNameErrorMessage() {
        usecase.register(name: empty, email: validMail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testRegisterAnUserWithEmptyPasswordDisplayPasswordErrorMessage() {
        usecase.register(name: validName, email: validMail, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWithoutAtLeastFiveCharactersInThePasswordDisplayPasswordErrorMessage() {
        usecase.register(name: validName, email: validMail, password: smallPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWithAllEmptyInputDisplayAllErrorMessages() {
        usecase.register(name: empty, email: empty, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWithAllInvalidInputDisplayAllErrorMessages() {
        usecase.register(name: empty, email: invalidEmail, password: smallPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWhenValidInputsDoesNotDisplayErroMessages() {
        usecase.register(name: validName, email: validMail, password: validPassword, birthdate: validDate)

        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

}
