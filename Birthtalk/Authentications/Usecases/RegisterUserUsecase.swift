import Foundation

typealias RegisterUserUsecaseParams = (name: String, email: String, password: String, birthdate: Date)

struct RegisterUserUsecase {

    private let gateway: AuthenticationGateway
    private let presenter: RegisterUserPresenter

    init(gateway: AuthenticationGateway, presenter: RegisterUserPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    func register(registerUserParams: RegisterUserUsecaseParams) {
        let invalidInputs: [AuthenticationErrorValidator] = [
            ValidateEmailEntity(email: registerUserParams.email),
            ValidateNameEntity(name: registerUserParams.name),
            ValidatePasswordEntity(password: registerUserParams.password)]
            .filter { !$0.isValid() }

        invalidInputs.forEach { presenter.failure(error: $0.error) }

        let isWithoutErrors = invalidInputs.count == 0
        if isWithoutErrors {
            gateway.register(name: registerUserParams.name, email: registerUserParams.email,
                             password: registerUserParams.password, birthdate: registerUserParams.birthdate,
                             completion: presentResult)
        }
    }

    private func presentResult(result: RegisterResult) {
        switch result {
        case .success: self.presenter.success()
        case let .failure(error): self.presenter.failure(error: error)
        }
    }

}
