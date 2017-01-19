@testable import Birthtalk

class RegisterUserPresenterStub: RegisterUserPresenter {

    var shownInvalidEmailErrorMessage = false
    var shownEmptyNameErrorMessage = false
    var shownInavlidEmailErrorMessage = false
    var shownInvalidPasswordErrorMessage = false
    var shownRegistredUser = false

    func failure(error: UserFormErrors) {
        switch error {
        case .invalidEmail: shownInvalidEmailErrorMessage = true
        case .invalidName: shownEmptyNameErrorMessage = true
        case .invalidPassword: shownInvalidPasswordErrorMessage = true
        }
    }

    func success() {
        shownRegistredUser = true
    }

}
