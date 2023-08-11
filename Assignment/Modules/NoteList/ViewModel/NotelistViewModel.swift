
final class NotelistViewModel {
    var notelist: [Notelist] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure

    func fetchNoteList() {
        self.eventHandler?(.loading)
        NetworkManager.shared.request(
            modelType: [Notelist].self,
            type: APIEndPoints.noteList)
        { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let notelists):
                self.notelist = notelists
                print(self.notelist)
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension NotelistViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
