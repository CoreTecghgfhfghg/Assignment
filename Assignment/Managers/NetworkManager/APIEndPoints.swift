
import Foundation

enum APIEndPoints {
    case noteList
}

extension APIEndPoints: EndPointType {
    var path: String {
        switch self {
        case .noteList:
            return Constant.API.noteListEndPoint
        }
    }

    var baseURL: String {
        switch self {
        case .noteList:
            return Constant.API.baseURL
        }
    }

    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .noteList:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .noteList:
            return nil
        }
    }

    var headers: [String: String]? {
        NetworkManager.commonHeaders
    }
}
