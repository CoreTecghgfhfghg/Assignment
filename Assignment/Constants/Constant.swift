
struct Constant {
    enum API {
        static let baseURL = "https://gosee.s3.amazonaws.com/"
        static let noteListEndPoint = "notelist.json"
    }
    
    struct NoteList {
        static let notes = "Notes"
        static let detail = "Notes Detail"
    }
}
