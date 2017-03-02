import Foundation

typealias RegisterResult = Result<UserEntity, AuthenticationError>

protocol AuthenticationGateway {
    func register(name: String, email: String, password: String, birthdate: Date, completion: @escaping ((RegisterResult) -> Void))
}
