import Foundation

struct RegisterUserUsecase {

    let presenter: RegisterUserPresenter

    func register(name: String, email: String, password: String, birthdate: Date) {
        guard isValidInputs(name: name, email: email, password: password, birthdate: birthdate) else { return }
    }

    private func isValidInputs(name: String, email: String, password: String, birthdate: Date) -> Bool {
        var invalidMessages = [() -> Void]()
        guard invalidMessages.count > 0 else { return false }
        if name.isEmpty { invalidMessages.append(presenter.invalidName) }
        if password.characters.count < 5 { invalidMessages.append(presenter.invalidPassword) }
        if email.isEmpty { invalidMessages.append(presenter.invalidEmail) }
        if !isValidEmail(email: email) { invalidMessages.append(presenter.invalidEmail) }
        invalidMessages.forEach { $0() }
        return true
    }

    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}
