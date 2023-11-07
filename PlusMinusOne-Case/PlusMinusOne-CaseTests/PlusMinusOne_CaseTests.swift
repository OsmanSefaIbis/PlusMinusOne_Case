//
//  PlusMinusOne_CaseTests.swift
//  PlusMinusOne-CaseTests
//
//  Created by Sefa İbiş on 2.11.2023.
//

import XCTest
import PlusMinusOne_Case // FIXME: Had to import for testing purposes, MockStructs did not work
@testable import PlusMinusOne_Case

final class PlusMinusOne_CaseTests: XCTestCase {
    
    private var viewModel: ProductDetailVM!
    private var view: MockProductDetailVC!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view)
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        viewModel = nil
    }
    
    
    func test_viewDidLoad_invokesRequiredSequence() {
        XCTAssertEqual(view.counter_setupUserInterface, 0)
        XCTAssertEqual(view.counter_configureUserInterface, 0)
        viewModel.viewDidLoad()
        XCTAssertEqual(view.counter_setupUserInterface, 1)
        XCTAssertEqual(view.counter_configureUserInterface, 1)
    }
    
    func test_getData_WhenDataAvailable() {
        
        let mockDataWannaBe: DetailData? = .init(
            id: 1,
            productBrand: "Dolce Gabanna",
            productType: "Hat",
            imageUrl: "www.someUrl.com",
            priceInfo: .init(value: 1, currency: "TL"),
            currentSocialFeed: .init(likeCount: 1, commentCounts: .init(
                averageRating: 5.0,
                anonymousCommentsCount: 5,
                memberCommentsCount: 5
            )))
        guard let data = mockDataWannaBe else { return }
        viewModel.data = data
        
        let result = viewModel.getData(.productBrand) as? String // when
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, data.productBrand)
    }
    
    func test_getData_WhenDataNotAvailable() {
        
        let result = viewModel.getData(.productBrand) as? String // when
        XCTAssertNil(result)
    }
    
    func test_getLatestSocial_WhenLatestUpdatedSocialAvailable() {
        let mockDataWannaBe: Social = .init(likeCount: 1, commentCounts: CommentInfo(averageRating: 1.0, anonymousCommentsCount: 1, memberCommentsCount: 1))
        
        viewModel.latestUpdatedSocial = mockDataWannaBe
        let result = viewModel.getLatestSocial() // when
        
        XCTAssertEqual(result?.likeCount, 1)
        XCTAssertEqual(result?.commentCounts?.averageRating, 1.0)
        XCTAssertEqual(result?.commentCounts?.anonymousCommentsCount, 1)
        XCTAssertEqual(result?.commentCounts?.memberCommentsCount, 1)
        
    }
    
    func test_getLatestSocial_WhenLatestUpdatedSocialUnavailable() {
        let result = viewModel.getLatestSocial() // when
        XCTAssertNil(result)
    }
    
    func test_didEndCountDown_stateUpdate() {
        viewModel.didEndCountdown() // when
        XCTAssertEqual(viewModel.socialState, .loading)
        
        // ProductDetailModel: var modifiedFlag: Bool = false, makes this test fail, changed it to true
    }
    
    func test_updateUserInterface_forStateSuccess_uponCurrentStateNotifiesViewToUpdateUI() {
        
    }
    
    func test_updateUserInterface_forStateLoading_uponCurrentStateNotifiesViewToUpdateUI() {
        
    }
    
    func test_updateUserInterface_forStateError_uponCurrentStateNotifiesViewToUpdateUI() {
        
    }
    
    
    
}
