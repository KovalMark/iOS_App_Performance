import UIKit

// MARK: - NewsVK model
struct NewsVKResponse: Decodable {
    let response: NewsVK
}

// MARK: - NewsVK
struct NewsVK: Decodable {
    let groups: [TitleVKNews]
    let items: [BodyVKNews]
    
    enum CodingKeys: String, CodingKey {
        case groups
        case items
    }
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
    
    enum CodingKeys: String, CodingKey {
        case attachments
    }
}

struct AttachBodyVKNews: Decodable {
    let photo: [PhotoVKNews]
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case photo
        case text
    }
}

struct PhotoVKNews: Decodable {
    let sizes: [SizesPhotoVKNews]
    
    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct SizesPhotoVKNews: Decodable {
    let type: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case type
        case url
    }
}
