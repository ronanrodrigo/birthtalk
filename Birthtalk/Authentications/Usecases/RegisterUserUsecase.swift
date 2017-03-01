import Foundation

struct RegisterUserUsecase {

    private let gateway: AuthenticationGateway
    private let presenter: RegisterUserPresenter

    init(gateway: AuthenticationGateway, presenter: RegisterUserPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    func register(name: String, email: String, password: String, birthdate: Date) {
        guard isValidInputs(name: name, email: email, password: password, birthdate: birthdate) else { return }
        gateway.register(name: name, email: email, password: password, birthdate: birthdate, completion: presentResult)
    }

    private func presentResult(result: Result<UserEntity, AuthenticationError>) {
        switch result {
        case .success: self.presenter.success()
        case let .failure(error): self.presenter.failure(error: error)
        }
    }

    private func isValidInputs(name: String, email: String, password: String, birthdate: Date) -> Bool {
        var errors = [AuthenticationError]()
        if name.isEmpty { errors.append(.invalidName) }
        if password.characters.count < 5 { errors.append(.invalidPassword) }
        if email.isEmpty { errors.append(.invalidEmail) }
        if !isValidEmail(email: email) { errors.append(.invalidEmail) }

        if errors.count == 0 { return true }
        errors.forEach(presenter.failure)
        return false
    }

    private func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: email)
    }

}
