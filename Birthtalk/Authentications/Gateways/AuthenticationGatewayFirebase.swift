import Foundation
import FirebaseAuth
import FirebaseDatabase

struct  AuthenticationGatewayFirebase: AuthenticationGateway {

    private let firAuth: FIRAuth

    init(firAuth: FIRAuth) {
        self.firAuth = firAuth
    }

    func register(userParams: RegisterUserBasicParams, completion: @escaping ((RegisterResult) -> Void)) {
        firAuth.createUser(withEmail: userParams.email, password: userParams.password) { user, error in
            if let authError = error {
                let result = RegisterResult.failure(AuthenticationError(rawValue: authError._code))
                completion(result)
                return
            }

            if let user = user {
                let userEntity = self.generateUserEntity(identifier: user.uid, name: userParams.name,
                                                         email: userParams.email, birthdate: userParams.birthdate)
                self.saveUserData(userId: user.uid, userEntity: userEntity, completion: completion)
            }
        }
    }

    private func saveUserData(userId: String, userEntity: UserEntity, completion: @escaping ((RegisterResult) -> Void)) {
        let reference = FIRDatabase.database().reference(fromURL: Enviroment.firebaseDatabase.rawValue)
        let userReference = reference.child(DatabasePath.users.rawValue).child(userId)
        let userDictionary = self.generateDictionary(name: userEntity.name, email: userEntity.email, birthdate: userEntity.birthdate)

        userReference.updateChildValues(userDictionary) { _, _ in
            let result = RegisterResult.success(userEntity)
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
