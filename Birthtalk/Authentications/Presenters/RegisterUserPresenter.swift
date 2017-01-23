protocol RegisterUserPresenter {
    func success()
    func failure(error: AuthenticationError)
}
