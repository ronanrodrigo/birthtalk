import Foundation

public typealias RegisterUserBasicParams = (name: String, email: String, password: String, birthdate: Date)

protocol User {
    var identifier: String? { get }
    var name: String { get }
    var email: String { get }
    var birthdate: Date { get }
}

struct UserEntity: User {
    let identifier: String?
    let name: String
    let email: String
    let birthdate: Date
}
