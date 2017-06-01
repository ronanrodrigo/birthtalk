import Foundation

typealias RegisterResult = Result<UserEntity, AuthenticationError>

protocol AuthenticationGateway {
    func register(userParams: RegisterUserBasicParams, completion: @escaping ((RegisterResult) -> Void))
}
