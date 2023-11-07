//
//  SocialDTO.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

struct SocialDTO: Codable {
    var results: [SocialFeed]?
}

struct SocialFeed: Codable {
    let id: Int?
    var social: Social?
}

struct Social: Codable {
    var likeCount: Int?
    var commentCounts: CommentInfo?
}

struct CommentInfo: Codable {
    var averageRating: Double?
    var anonymousCommentsCount, memberCommentsCount: Int?
}

