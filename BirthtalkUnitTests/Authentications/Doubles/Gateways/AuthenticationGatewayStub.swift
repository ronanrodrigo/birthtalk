import Foundation
@testable import Birthtalk

class AuthenticationGatewayStub: AuthenticationGateway {

    var registeredUser: UserEntity?
    var registerResult: Result<UserEntity, AuthenticationError>?

    func register(userParams: RegisterUserBasicParams, completion: @escaping ((RegisterResult) -> Void)) {
        guard let registerResult = registerResult else { return }

        switch registerResult {
        case .failure(_):
            registeredUser = nil
        case .success(_):
            registeredUser = UserEntity(identifier: nil, name: userParams.name, email: userParams.email,
                                        birthdate: userParams.birthdate)
        }

        completion(registerResult)

    }

}
