import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
   private final let baseUrl = "https://www.googleapis.com/books/v1/"

    // Genel isteği yöneten fonksiyon
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod = .get,
        model: T.Type,
        queryParams: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let requestUrl = baseUrl + urlString
        guard var urlComponents = URLComponents(string: requestUrl) else {
            debugPrint("urlComponents Alinamadi")

            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Eğer query parametreleri varsa, URL'ye ekliyoruz
        if let queryParams = queryParams {
            
            for (key, value) in queryParams {
                print("\(key): \(value)")
            }
            
            if  method == .get{
                urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }

        guard let url = urlComponents.url else {
            debugPrint("Url Alinamadi")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        debugPrint("Request Url \(requestUrl)")
        request.httpMethod = method.rawValue
        
        if let queryParams = queryParams {
            if  method != .get && method != .delete {
                do {
                    
                    let jsonData = try JSONSerialization.data(withJSONObject: queryParams, options: [])

                    request.httpBody = jsonData
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                } catch {
                    completion(.failure(error))
                    return
                }
            }
        }


        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    AppPopUp.shared.showErrorAlert(message: error.localizedDescription)
                }
                completion(.failure(error))
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    AppPopUp.shared.showErrorAlert(message: "No data received.")
                }
                completion(.failure(NetworkError.noData))
                return
            }

            do {
          
                    let decodedData = try JSONDecoder().decode(T.self, from: data)


                completion(.success(decodedData))
            } catch {
                DispatchQueue.main.async {
                    AppPopUp.shared.showErrorAlert(message: "Failed to parse data.")
                }
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
