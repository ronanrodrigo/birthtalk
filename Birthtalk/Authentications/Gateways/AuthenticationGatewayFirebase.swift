import Foundation
import FirebaseAuth
import FirebaseDatabase

struct AuthenticationGatewayFirebase: AuthenticationGateway {

    func register(name: String, email: String, password: String, birthdate: Date,
                  completion: @escaping ((Result<UserEntity, RequestError>) -> Void)) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                let result = Result<UserEntity, RequestError>.failure(self.requestError(of: error))
                completion(result)
                return
            }

            guard let user = user else {
                // completion
                return
            }

            let reference = FIRDatabase.database().reference(fromURL: "http://birthtalk-e14dd.firebaseio.com")
            let userReference = reference.child("users").child(user.uid)
            let values = ["name": name]
            userReference.updateChildValues(values)

        })
    }

    private func requestError(of error: Error) -> RequestError {
        return .notConnectedToInternet
    }

}
