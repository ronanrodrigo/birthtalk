import Foundation

struct RegisterUserUsecase {

    let presenter: RegisterUserPresenter
    let gateway: AuthenticationGateway

    func register(name: String, email: String, password: String, birthdate: Date) {
        guard isValidInputs(name: name, email: email, password: password, birthdate: birthdate) else { return }
        gateway.register(name: name, email: email, password: password, birthdate: birthdate)
        presenter.success()
    }

    private func isValidInputs(name: String, email: String, password: String, birthdate: Date) -> Bool {
        var invalidMessages = [() -> Void]()
        if name.isEmpty { invalidMessages.append(presenter.invalidName) }
        if password.characters.count < 5 { invalidMessages.append(presenter.invalidPassword) }
        if email.isEmpty { invalidMessages.append(presenter.invalidEmail) }
        if !isValidEmail(email: email) { invalidMessages.append(presenter.invalidEmail) }
        guard invalidMessages.count > 0 else { return true }
        invalidMessages.forEach { $0() }
        return false
    }

    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}
