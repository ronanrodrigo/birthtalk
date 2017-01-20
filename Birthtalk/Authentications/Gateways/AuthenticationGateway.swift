import Foundation

typealias RegisterResult = Result<UserEntity, RequestError>

protocol AuthenticationGateway {
    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: ((RegisterResult) -> Void))
}
