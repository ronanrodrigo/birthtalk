import Foundation

struct RegisterUserUsecase {

    private let gateway: AuthenticationGateway
    private let presenter: RegisterUserPresenter

    init(gateway: AuthenticationGateway, presenter: RegisterUserPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    func register(name: String, email: String, password: String, birthdate: Date) {
        let invalidInputs: [AuthenticationErrorValidator] = [
            ValidateEmailEntity(email: email),
            ValidateNameEntity(name: name),
            ValidatePasswordEntity(password: password)]
            .filter { !$0.isValid() }

        invalidInputs.forEach { presenter.failure(error: $0.error) }

        let isWithoutErrors = invalidInputs.count == 0
        if isWithoutErrors {
            gateway.register(name: name, email: email, password: password, birthdate: birthdate, completion: presentResult)
        }
    }

    private func presentResult(result: RegisterResult) {
        switch result {
        case .success: self.presenter.success()
        case let .failure(error): self.presenter.failure(error: error)
        }
    }

}
