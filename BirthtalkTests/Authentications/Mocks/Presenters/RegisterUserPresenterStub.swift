@testable import Birthtalk

class RegisterUserPresenterStub: RegisterUserPresenter {

    var shownInvalidEmailErrorMessage = false
    var shownEmptyNameErrorMessage = false
    var shownInavlidEmailErrorMessage = false
    var shownInvalidPasswordErrorMessage = false
    var shownRegistredUser = false
    var showInvalidRequestErrorMessage = false

    func failure(error: RegisterError) {
        switch error {
        case .invalidEmail: shownInvalidEmailErrorMessage = true
        case .invalidName: shownEmptyNameErrorMessage = true
        case .invalidPassword: shownInvalidPasswordErrorMessage = true
        }
    }

    func failure(error: RequestError) {
        switch error {
        case .notConnectedToInternet: showInvalidRequestErrorMessage = true
        }
    }

    func success() {
        shownRegistredUser = true
    }

}
