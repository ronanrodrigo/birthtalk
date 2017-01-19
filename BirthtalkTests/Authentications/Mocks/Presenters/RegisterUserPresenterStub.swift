@testable import Birthtalk

class RegisterUserPresenterStub: RegisterUserPresenter {

    var shownInvalidEmailErrorMessage = false
    var shownEmptyNameErrorMessage = false
    var shownInavlidEmailErrorMessage = false
    var shownInvalidPasswordErrorMessage = false

    func showInvalidEmailMessage() {
        shownInvalidEmailErrorMessage = true
    }

    func showEmptyNameMessage() {
        shownEmptyNameErrorMessage = true
    }

    func showInvalidPasswordMessage() {
        shownInvalidPasswordErrorMessage = true
    }

}
