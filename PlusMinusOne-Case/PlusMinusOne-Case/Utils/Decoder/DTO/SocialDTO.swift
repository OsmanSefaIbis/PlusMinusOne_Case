//
//  SocialDTO.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

// TODO: Based on the retention(1min) change the likeCount and comments increasingly with randomness(not substantial)
// TODO: Modify social.json file upon retention
// FIXME: First keep the retention to 5 seconds just for development, change it to 1 min later

struct SocialDTO: Decodable {
    let results: [SocialFeed]?
}

struct SocialFeed: Decodable {
    let id: Int?
    let social: Social?
}

struct Social: Decodable {
    let likeCount: Int?
    let commentCounts: CommentInfo?
}

struct CommentInfo: Decodable {
    let averageRating: Double?
    let anonymousCommentsCount, memberCommentsCount: Int?
}
