import Foundation

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
