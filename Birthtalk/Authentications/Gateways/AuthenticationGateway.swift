import Foundation

protocol AuthenticationGateway {
    func register(name: String, email: String, password: String, birthdate: Date)
}
