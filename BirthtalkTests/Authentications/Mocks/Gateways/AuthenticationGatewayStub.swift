import Foundation
@testable import Birthtalk

class AuthenticationGatewayStub: AuthenticationGateway {

    var registeredUser: UserEntity?
    var registerResult: Result<UserEntity, RequestError>?

    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: @escaping ((Result<UserEntity, RequestError>) -> Void)) {
        guard let registerResult = registerResult else { return }

        switch registerResult {
        case .failure(_):
            registeredUser = nil
        case .success(_):
            registeredUser = UserEntity(identifier: nil, name: name, email: email, birthdate: birthdate)
        }

        completion(registerResult)

    }

}
