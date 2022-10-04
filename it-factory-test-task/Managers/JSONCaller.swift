
import Foundation

class JSONCaller {
    
    func jsonCaller(completion: @escaping(Result<[Section], Error>) -> Void ) {
        guard let path = Bundle.main.path(forResource: "jsonviewer", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(ArticlesModel.self, from: jsonData)
            completion(.success(result.sections))
        } catch {
            print("Error: \(error)")
        }
    }
}


