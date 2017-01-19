@testable import Birthtalk

class RegisterUserPresenterStub: RegisterUserPresenter {

    var shownInvalidEmailErrorMessage = false
    var shownEmptyNameErrorMessage = false
    var shownInavlidEmailErrorMessage = false
    var shownInvalidPasswordErrorMessage = false
    var shownRegistredUser = false

    func invalidEmail() {
        shownInvalidEmailErrorMessage = true
    }

    func invalidName() {
        shownEmptyNameErrorMessage = true
    }

    func invalidPassword() {
        shownInvalidPasswordErrorMessage = true
    }

    func success() {
        shownRegistredUser = true
    }

}
