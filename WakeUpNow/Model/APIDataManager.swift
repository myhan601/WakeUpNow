//
//  APIDataManager.swift
//  WakeUpNow
//
//  Created by SAMSUNG on 5/13/24.
//

import UIKit

class APIDataManager {
    
    static let shared = APIDataManager()
    private init() { }
    
    func readAPI(completion: @escaping (Result<Words, Error>) -> ()) {
        guard let url = URL(string: "https://jlpt-vocab-api.vercel.app/api/words/random?level=1") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Error: \(error)")
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            guard let words = try? JSONDecoder().decode(Words.self, from: data) else {
                completion(.failure(error!))
                return
            }
            completion(.success(words))
        }.resume()
    }
}

