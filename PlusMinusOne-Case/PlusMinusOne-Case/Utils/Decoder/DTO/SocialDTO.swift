//
//  SocialDTO.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 3.11.2023.
//

// ThinkTODO: Based on the retention(1min) change the likeCount and comments increasingly with randomness(not substantial)
// ThinkTODO: Find a way to change that json or keep the original and populate another
// Do this or somethin else to have a convincing UX that mimics that behavior
struct SocialDTO: Decodable {
    let likeCount: Int?
    let commentCounts: CommentInfo?
}

struct CommentInfo: Decodable {
    let averageRating, anonymousCommentsCount, memberCommentsCount: Int?
}
