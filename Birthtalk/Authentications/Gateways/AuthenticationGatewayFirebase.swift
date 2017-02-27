import Foundation
import FirebaseAuth
import FirebaseDatabase

struct  AuthenticationGatewayFirebase: AuthenticationGateway {

    typealias RegisterResult = Result<UserEntity, AuthenticationError>
    private let firAuth: FIRAuth

    init(firAuth: FIRAuth) {
        self.firAuth = firAuth
    }

    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: @escaping ((Result<UserEntity, AuthenticationError>) -> Void)) {
        firAuth.createUser(withEmail: email, password: password) { user, error in
            if let authError = error {
                let result = RegisterResult.failure(AuthenticationError(rawValue: authError._code))
                completion(result)
                return
            }

            if let user = user {
                self.createUser(user: user, name: name, email: email, birthdate: birthdate, completion: completion)
            }
        }
    }

    private func createUser(user: FIRUser, name: String, email: String, birthdate: Date,
                            completion: @escaping ((Result<UserEntity, AuthenticationError>) -> Void)) {
        let reference = FIRDatabase.database().reference(fromURL: Enviroment.firebaseDatabase.rawValue)
        let userReference = reference.child("users").child(user.uid)
        let userDictionary = self.generateDictionary(name: name, email: email, birthdate: birthdate)

        userReference.updateChildValues(userDictionary) { _, _ in
            let result = RegisterResult.success(self.generateUserEntity(identifier: user.uid, name: name,
                                                                        email: email, birthdate: birthdate))
            completion(result)
        }
    }

    private func generateDictionary(name: String, email: String, birthdate: Date) -> [String: Any] {
        return ["name": name, "email": email, "birthdate": birthdate.timeIntervalSince1970]
    }

    private func generateUserEntity(identifier: String, name: String, email: String, birthdate: Date) -> UserEntity {
        return UserEntity(identifier: identifier, name: name, email: email, birthdate: birthdate)
    }

}
