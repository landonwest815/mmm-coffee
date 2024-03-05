//
//  WordValidator.swift
//  coffeeTest
//
//  Created by Landon West on 3/5/24.
//

import Foundation

class WordValidator {
    private var cache: [String: Bool] = [:]
    private let session = URLSession.shared

    func isWordValid(_ word: String, completion: @escaping (Bool) -> Void) {
        if let cachedValue = cache[word.lowercased()] {
            completion(cachedValue)
            return
        }

        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            completion(false)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            let isValid = (response as? HTTPURLResponse)?.statusCode == 200
            self?.cache[word.lowercased()] = isValid
            completion(isValid)
        }
        
        task.resume()
    }
}
