@testable import Birthtalk

class RegisterUserPresenterStub: RegisterUserPresenter {

    var shownInvalidEmailErrorMessage = false
    var shownEmptyNameErrorMessage = false
    var shownInavlidEmailErrorMessage = false
    var shownInvalidPasswordErrorMessage = false
    var shownRegistredUser = false
    var showInvalidRequestErrorMessage = false

    func failure(error: AuthenticationError) {
        switch error {
        case .invalidEmail: shownInvalidEmailErrorMessage = true
        case .invalidName: shownEmptyNameErrorMessage = true
        case .invalidPassword: shownInvalidPasswordErrorMessage = true
        case .networkError: showInvalidRequestErrorMessage = true
        default: return
        }
    }

    func success() {
        shownRegistredUser = true
    }

}
