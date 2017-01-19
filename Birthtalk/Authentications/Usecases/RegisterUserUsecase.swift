import Foundation

struct RegisterUserUsecase {

    let presenter: RegisterUserPresenter

    func register(name: String, email: String, password: String, birthdate: Date) {
        guard isValidInputs(name: name, email: email, password: password, birthdate: birthdate) else { return }
    }

    private func isValidInputs(name: String, email: String, password: String, birthdate: Date) -> Bool {
        var invalidMessages = [() -> Void]()
        if name.isEmpty { invalidMessages.append(presenter.showEmptyNameMessage) }
        if password.characters.count < 5 { invalidMessages.append(presenter.showInvalidPasswordMessage) }
        if email.isEmpty { invalidMessages.append(presenter.showInvalidEmailMessage) }
        if !isValidEmail(email: email) { invalidMessages.append(presenter.showInvalidEmailMessage) }
        guard invalidMessages.count > 0 else { return false }
        invalidMessages.forEach { $0() }
        return true
    }

    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}
