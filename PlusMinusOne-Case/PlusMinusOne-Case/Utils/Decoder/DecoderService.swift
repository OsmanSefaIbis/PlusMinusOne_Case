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
            let error = NSError(domain: "DecoderService.decode", code: 1001, userInfo: [NSLocalizedDescriptionKey: "JSON file not found in project directory."]) // TODO: Migrate to Localize Enum
            completion(.failure(error))
        }
    }
}

//    static func decodeModifyEncodeSave<T: Codable>(resource: String, as type: T.Type, completion: @escaping (Result<Void, Error>) -> Void) {
//
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//            let fileURL = documentDirectory.appendingPathComponent("\(resource).json")
//            do {
//                try Data(contentsOf: fileURL) // TODO: Aborted doing this
//                var decodedObject = try JSONDecoder().decode(type, from: data)
//
//                if var socialDTO = decodedObject as? SocialInfo {
//                    for i in 0..<(socialDTO.results?.count ?? 0) {
//                        socialDTO.results?[i].social?.likeCount! += Int.random(in: -30...30)
//                        socialDTO.results?[i].social?.commentCounts?.averageRating! = Double.random(in: 1...5)
//                        socialDTO.results?[i].social?.commentCounts?.anonymousCommentsCount! += Int.random(in: -20...20)
//                        socialDTO.results?[i].social?.commentCounts?.memberCommentsCount! += Int.random(in: -20...20)
//                    }
//                    let modifiedData = try JSONEncoder().encode(socialDTO)
//                    try modifiedData.write(to: fileURL)
//                } else {
//                    completion(.failure(NSError(domain: "DecoderService.decodeModifyEncodeSave", code: 1003, userInfo: [NSLocalizedDescriptionKey: "Decoded object is not of the expected type"] )))
//                    return
//                }
//
//                completion(.success(()))
//            } catch {
//                completion(.failure(error))
//            }
//        } else {
//            completion(.failure(NSError(domain: "DecoderService.decodeModifyEncodeSave", code: 1002, userInfo: [NSLocalizedDescriptionKey: "Document directory not found"] )))
//        }
//    }
