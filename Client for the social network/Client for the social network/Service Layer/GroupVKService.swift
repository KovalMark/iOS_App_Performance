import UIKit
import Alamofire
import RealmSwift

final class GroupVKService: AsyncOperation {
    
    // MARK: - loadVKGroup
    let baseUrl = "https://api.vk.com"
    let apiKey = Session.instance.token
    
    func loadVKGroup() {
        let path = "/method/groups.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "extended": "1",
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
            print("\nСписок групп\n")
            print(response.value ?? "")
        }
    }
    
    // MARK: - groupAdd
    func groupAdd(completion: @escaping ([GroupVKArray]) -> Void){
        let path = "/method/groups.get"
        let methodName: Parameters = [
            "access_token": apiKey,
            "extended": "1",
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            guard let userArray = try? JSONDecoder().decode(GroupVKResponse.self, from: data) else { return }
            self?.saveGroupData(userArray.response.items)
            completion(userArray.response.items)
        }
    }
    
    // MARK: - saveGroupData
    func saveGroupData(_ userGroup: [GroupVKArray]) {
        do {
            let realm = try Realm()
            let oldGroupVKArray = realm.objects(GroupVKArray.self)
            realm.beginWrite()
            realm.delete(oldGroupVKArray)
            realm.add(userGroup)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    // MARK: - AsyncOperation
    override func cancel() {
        request.cancel()
        super.cancel()
    }
    
    private var request: DataRequest = AF.request("https://api.vk.com/method/friends.get?access_token=8ea3c7fafd7b82fea6a0f1beefd5b0f581028809c2653548555245b243cfa1058be818d9538d6de06721c&fields=photo_50&v=5.131")
    var data: Data?
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self]
            response in
            self?.data = response.data
            self?.state = .finished
        }
    }
}
