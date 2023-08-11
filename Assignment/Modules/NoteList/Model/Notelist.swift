
import Foundation

struct Notelist: Codable {
    let id: Int
    let address: String
    let avgRating: Int
    let description, headLine: String
    let suggestedAsAdvertisedHotspot, hotSpotUserStatus, noteForHotSpotLocation, isPublished: Bool
    let latitude, longitude: Double
    let postedDate: String
    let privacy: Int
    let shareable: Bool
    let updatedDate: String
    let isDeletable, isEditable: Bool
    let notePoint: Double
    let tags: [Tag]
    let uploads: [imageDetail]
    let coverPic: CoverPic
    let userDetails: UserDetails
    let weight: Double
    let favoriteStatus, status: Bool
    let commentsCount, count, userRating: Int
    let favoriteID: Int?
    let reported, hotspotRejected, published, deletable: Bool
    let editable: Bool
    let noteDate: String
    let hotSpot, isHotspotRejected: Bool
    let landMark: String
}

struct CoverPic: Codable {
    let url: String
}

struct UserDetails: Codable {
    let name: String
    let upload: Upload
}

struct Upload: Codable {
    let url: String
}

struct Tag: Codable {
    let name: String
}

struct imageDetail: Codable {
    let url: String
    let description: String
}
