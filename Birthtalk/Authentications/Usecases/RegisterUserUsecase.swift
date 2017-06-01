import Foundation

struct RegisterUserUsecase {

    private let gateway: AuthenticationGateway
    private let presenter: RegisterUserPresenter

    init(gateway: AuthenticationGateway, presenter: RegisterUserPresenter) {
        self.gateway = gateway
        self.presenter = presenter
    }

    func register(userParams: RegisterUserBasicParams) {
        let invalidInputs: [AuthenticationErrorValidator] = [
            ValidateEmailEntity(email: userParams.email),
            ValidateNameEntity(name: userParams.name),
            ValidatePasswordEntity(password: userParams.password)]
            .filter { !$0.isValid() }

        invalidInputs.forEach { presenter.failure(error: $0.error) }

        let isWithoutErrors = invalidInputs.count == 0
        if isWithoutErrors {
            gateway.register(userParams: userParams, completion: presentResult)
        }
    }

    private func presentResult(result: RegisterResult) {
        switch result {
        case .success: self.presenter.success()
        case let .failure(error): self.presenter.failure(error: error)
        }
    }

}
