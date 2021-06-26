//
//  NetworkDataFetcher.swift
//  PhotoGallery
//
//  Created by talgat on 6/24/21.
//

import Foundation


class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("ERror received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJOSN(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJOSN<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {
            return nil
        }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
