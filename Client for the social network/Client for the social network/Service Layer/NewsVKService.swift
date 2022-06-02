import UIKit
import Alamofire

// MARK: - NewsVKService
// MARK: - Use DispatchQueue.global().async
final class NewsVKService {
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    // функция для отображения полученных данных в консоль
    func loadVKNews() {
        DispatchQueue.global().async {
            let path = "/method/newsfeed.get"
            let methodName: Parameters = [
                "access_token": self.apiKey,
                "filters": "post,photo",
                "v": "5.130"
            ]
            
            let url = self.baseUrl+path
            
            AF.request(url, method: .get, parameters: methodName).responseJSON { response in
                print("\nСписок новостей\n")
                print(response.value ?? "")
            }
        }
    }
    
    // добавление заголовка, подзаголовка и аватарки поста
    func titleNewsAdd(completion: @escaping ([TitleVKNews]) -> Void){
        DispatchQueue.global().async {
            let path = "/method/newsfeed.get"
            let methodName: Parameters = [
                "access_token": self.apiKey,
                "filters": "post",
                "v": "5.130"
            ]
            
            let url = self.baseUrl+path
            
            AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
                guard let data = response.value else { return }
                let userArray = try! JSONDecoder().decode(NewsVKResponse.self, from: data)
                completion(userArray.response.groups)
            }
        }
    }
    
    // добавление фото и текста поста
    func bodyNewsAdd(completion: @escaping ([BodyVKNews]) -> Void){
        DispatchQueue.global().async {
            let path = "/method/newsfeed.get"
            let methodName: Parameters = [
                "access_token": self.apiKey,
                "filters": "photo",
                "v": "5.130"
            ]
            
            let url = self.baseUrl+path
            
            AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
                guard let data = response.value else { return }
                let userArray = try! JSONDecoder().decode(NewsVKResponse.self, from: data)
                completion(userArray.response.items)
            }
        }
    }
}
