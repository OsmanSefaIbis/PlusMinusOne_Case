//
//  JSONDecoder.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

import Foundation

final class DecoderService {
    
    static func decode<T: Decodable>(resource: String, as type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedObject = try JSONDecoder().decode(type, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        } else {
            let error = NSError(domain: "JSONDecoderService", code: 1001, userInfo: [NSLocalizedDescriptionKey: "JSON file not found in project directory."]) // TODO: Migrate to Localize Enum
            completion(.failure(error))        }
    }
}

