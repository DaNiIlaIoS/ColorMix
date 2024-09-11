//
//  NetworkManager.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchColor(hex: String, completion: @escaping (String?) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.thecolorapi.com"
        urlComponents.path = "/id"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "hex", value: hex),
            URLQueryItem(name: "format", value: "json")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "ERROR")
                return
            }
            
            if let jsonData = data {
                let responseData = try? JSONDecoder().decode(ModelColor.self, from: jsonData)
                let colorName = responseData?.name.value
                completion(colorName)
            }
        }.resume()
    }
}
