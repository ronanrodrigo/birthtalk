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
        usecase = RegisterUserUsecase(gateway: gateway, presenter: presenter)
    }

    func testRegisterAnUserWithEmptyEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: empty)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: validPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithInvalidEmailDisplayEmailErrorMessage() {
        let user = generateUserEntity(email: invalidEmail)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: validPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyNameDisplayNameErrorMessage() {
        let user = generateUserEntity(name: empty)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: validPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithEmptyPasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity()

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: empty,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithoutAtLeastFiveCharactersInThePasswordDisplayPasswordErrorMessage() {
        let user = generateUserEntity()

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: smallPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllEmptyInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: empty,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithAllInvalidInputDisplayAllErrorMessages() {
        let user = generateUserEntity(name: empty, email: empty)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: smallPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertTrue(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertTrue(presenter.shownInvalidEmailErrorMessage)
        XCTAssertTrue(presenter.shownEmptyNameErrorMessage)
        XCTAssertFalse(presenter.shownRegistredUser)
        XCTAssertNil(gateway.registeredUser)
    }

    func testRegisterAnUserWithValidInputSaveDataAndPresentSuccessMessage() {
        let user = generateUserEntity()
        gateway.registerResult = Result.success(user)

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: validPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

        XCTAssertNotNil(gateway.registeredUser)
        XCTAssertEqual(gateway.registeredUser!.email, user.email)
        XCTAssertEqual(gateway.registeredUser!.identifier, user.identifier)
        XCTAssertTrue(presenter.shownRegistredUser)
        XCTAssertFalse(presenter.shownInvalidPasswordErrorMessage)
        XCTAssertFalse(presenter.shownInvalidEmailErrorMessage)
        XCTAssertFalse(presenter.shownEmptyNameErrorMessage)
    }

    func testRegisterAnUserWithGatewayErrorDisplayGatewayErrorMessage() {
        gateway.registerResult = Result.failure(AuthenticationError.networkError)
        let user = generateUserEntity()

        let userParams = RegisterUserBasicParams(name: user.name, email: user.email, password: validPassword,
                                                           birthdate: user.birthdate)
        usecase.register(userParams: userParams)

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
