import UIKit


class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getMainRequest(completed: @escaping (Result< FlightModel, ErrorMessages>) -> Void) {
        
        let parameters = "{\n    \"startLocationCode\": \"LED\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://vmeste.wildberries.ru/stream/api/avia-service/v1/suggests/getCheap")!,timeoutInterval: Double.infinity)
        request.addValue("vmeste.wildberries.ru", forHTTPHeaderField: "authority")
        request.addValue("application/json, text/plain, */*", forHTTPHeaderField: "accept")
        request.addValue("no-cache", forHTTPHeaderField: "cache-control")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("https://vmeste.wildberries.ru", forHTTPHeaderField: "origin")
        request.addValue("no-cache", forHTTPHeaderField: "pragma")
        request.addValue("https://vmeste.wildberries.ru/avia", forHTTPHeaderField: "referer")
        request.addValue("empty", forHTTPHeaderField: "sec-fetch-dest")
        request.addValue("cors", forHTTPHeaderField: "sec-fetch-mode")
        request.addValue("same-origin", forHTTPHeaderField: "sec-fetch-site")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let flightResult            = try decoder.decode(FlightModel.self, from: data)
                completed(.success(flightResult))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
        
    }
}
