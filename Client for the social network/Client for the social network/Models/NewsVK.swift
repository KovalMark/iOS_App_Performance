import UIKit

// MARK: - NewsVK model
struct NewsVKResponse: Decodable {
    let response: NewsVK
}

// MARK: - NewsVK
struct NewsVK: Decodable {
    let groups: [TitleVKNews]
    let items: [BodyVKNews]
}

// MARK: - TitleVKNews
struct TitleVKNews: Decodable {
    let name: String
    let screenName: String
    let avatarPost: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case screenName = "screen_name"
        case avatarPost = "photo_100"
    }
}

// MARK: - BodyVKNews
struct BodyVKNews: Decodable {
    let attachments: [AttachBodyVKNews]
    // тут можно достать массивы с лайками и комментами
}

struct AttachBodyVKNews: Decodable {
    let photo: [PhotoVKNews]
    let text: String
}

struct PhotoVKNews: Decodable {
    let sizes: [SizesPhotoVKNews]
}

struct SizesPhotoVKNews: Decodable {
    let type: String
    let url: String
}
