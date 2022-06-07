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
    
    // парсинг данных
    func newsAdd(completion: @escaping (NewsVK) -> Void){
        DispatchQueue.global().async {
            let path = "/method/newsfeed.get"
            let methodName: Parameters = [
                "access_token": self.apiKey,
                "filters": "post,photo",
                "v": "5.130"
            ]
            
            let url = self.baseUrl+path
            
            AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
                guard let data = response.value else { return }
                do {
                    let userArray = try JSONDecoder().decode(NewsVKResponse.self, from: data)
                    completion(userArray.response)
                } catch {
                    print(error)
                }
            }
        }
    }
}
