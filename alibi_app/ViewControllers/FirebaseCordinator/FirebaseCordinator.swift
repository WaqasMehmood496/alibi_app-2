
import Firebase
typealias Completion = ((Result<User?, Error>) -> Void)
class FirebaseCordinator{
    static let instance = FirebaseCordinator()
    private let auth = Auth.auth()
    
    func register(email:String , password:String, completion: @escaping Completion){
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            }
            else{
                completion(.success(result?.user))
            }
        }
    }
    
    
    func login(email:String , password:String, completion: @escaping Completion){
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(.failure(error))
            }
            else{
                completion(.success(result?.user))
            }
        }
    }
    
}
