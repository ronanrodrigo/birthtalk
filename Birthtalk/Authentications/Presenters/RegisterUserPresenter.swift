protocol RegisterUserPresenter {
    func success()
    func failure(error: RegisterError)
    func failure(error: RequestError)
}
