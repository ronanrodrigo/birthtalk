import Foundation
@testable import Birthtalk

class AuthenticationGatewayStub: AuthenticationGateway {

    var registeredUser: UserEntity?
    var registerResult: RegisterResult?

    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: ((RegisterResult) -> Void)) {
        guard let registerResult = registerResult else { return }

        switch registerResult {
        case .failure(_):
            registeredUser = nil
        case .success(_):
            registeredUser = UserEntity(identifier: nil, name: name, email: email, password: password,
                                        birthdate: birthdate)
        }

        completion(registerResult)

    }

}
