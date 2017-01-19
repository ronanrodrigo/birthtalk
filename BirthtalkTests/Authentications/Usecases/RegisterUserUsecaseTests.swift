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

    func testDoNotRegisterAnUserWithEmptyEmail() {
        usecase.register(name: validName, email: empty, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testDoNotRegisterAnUserWithInvalidEmail() {
        usecase.register(name: validName, email: invalidEmail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testDoNotRegisterAnUserWithEmptyName() {
        usecase.register(name: empty, email: validMail, password: validPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
    }

    func testDoNotRegisterAnUserEmptyPassword() {
        usecase.register(name: validName, email: validMail, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testDoNotRegisterAnUserWithoutAtLeastFiveCharactersInThePassword() {
        usecase.register(name: validName, email: validMail, password: smallPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testDoNotRegisterAnUserWithAllEmptyFields() {
        usecase.register(name: empty, email: empty, password: empty, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
    }

    func testDoNotRegisterAnUserWithAllInvalidFields() {
        usecase.register(name: empty, email: invalidEmail, password: smallPassword, birthdate: validDate)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
    }

}
