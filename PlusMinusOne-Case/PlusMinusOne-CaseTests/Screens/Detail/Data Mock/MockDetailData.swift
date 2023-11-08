//
//  MockDetailData.swift
//  PlusMinusOne-CaseTests
//
//  Created by Sefa İbiş on 8.11.2023.
//

// Intended to use MockData's here

struct MockDetailData {
    let id: Int
    let productBrand: String
    let productType: String
    let imageUrl: String
    let priceInfo: MockPrice
    var currentSocialFeed: MockSocial?
}
struct MockPrice {
    let value: Double
    let currency: String
}
struct MockSocial {
    var likeCount: Int
    var commentCounts: MockCommentInfo
}
struct MockCommentInfo {
    var averageRating: Double
    var anonymousCommentsCount, memberCommentsCount: Int
}


