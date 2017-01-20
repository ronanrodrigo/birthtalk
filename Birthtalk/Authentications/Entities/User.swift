import Foundation

protocol User: Equatable {
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

extension UserEntity: Equatable {
    static func == (lhs: UserEntity, rhs: UserEntity) -> Bool {
        return lhs.identifier == rhs.identifier &&
            lhs.email == rhs.email
    }
}
