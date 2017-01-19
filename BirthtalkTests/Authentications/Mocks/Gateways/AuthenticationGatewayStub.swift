import Foundation
@testable import Birthtalk

class AuthenticationGatewayStub: AuthenticationGateway {

    var registeredUser: UserEntity?

    func register(name: String, email: String, password: String, birthdate: Date) {
        registeredUser = UserEntity(identifier: nil, name: name, email: email, password: password, birthdate: birthdate)
    }

}
