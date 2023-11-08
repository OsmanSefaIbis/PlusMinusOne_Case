//
//  PlusMinusOne_CaseTests.swift
//  PlusMinusOne-CaseTests
//
//  Created by Sefa İbiş on 2.11.2023.
//

import XCTest
@testable import PlusMinusOne_Case

final class PlusMinusOne_CaseTests: XCTestCase {
    
    private var viewModelDetail: ProductDetailVM!
    private var viewModelGallery: ProductGalleryVM!
    private var viewDetail: MockProductDetailVC!
    private var viewGallery: MockProductGalleryVC!
    
    
    override func setUp() {
        super.setUp()
        viewDetail = .init()
        viewModelDetail = .init(view: viewDetail)
        viewGallery = .init()
        viewModelGallery = .init(view: viewGallery)
        
    }
    
    override func tearDown() {
        super.tearDown()
        viewDetail = nil
        viewModelDetail = nil
        viewGallery = nil
        viewModelGallery = nil
    }
    
    // - Start of - ProductDetail ViewModel
    func test_viewDidLoad_invokesSetupAndConfigurationOfUserInterface() {
        XCTAssertEqual(viewDetail.counter_setupUserInterface, 0)
        XCTAssertEqual(viewDetail.counter_configureUserInterface, 0)
        viewModelDetail.viewDidLoad()
        XCTAssertEqual(viewDetail.counter_setupUserInterface, 1)
        XCTAssertEqual(viewDetail.counter_configureUserInterface, 1)
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
        viewModelDetail.data = data
        
        let result = viewModelDetail.getData(.productBrand) as? String // when
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result, data.productBrand)
    }
    
    func test_getData_WhenDataNotAvailable() {
        
        let result = viewModelDetail.getData(.productBrand) as? String // when
        XCTAssertNil(result)
    }
    
    func test_getLatestSocial_WhenLatestUpdatedSocialAvailable() {
        let mockDataWannaBe: Social = .init(likeCount: 1, commentCounts: CommentInfo(averageRating: 1.0, anonymousCommentsCount: 1, memberCommentsCount: 1))
        
        viewModelDetail.latestUpdatedSocial = mockDataWannaBe
        let result = viewModelDetail.getLatestSocial() // when
        
        XCTAssertEqual(result?.likeCount, 1)
        XCTAssertEqual(result?.commentCounts?.averageRating, 1.0)
        XCTAssertEqual(result?.commentCounts?.anonymousCommentsCount, 1)
        XCTAssertEqual(result?.commentCounts?.memberCommentsCount, 1)
        
    }
    
    func test_getLatestSocial_WhenLatestUpdatedSocialUnavailable() {
        let result = viewModelDetail.getLatestSocial() // when
        XCTAssertNil(result)
    }
    
    func test_didEndCountDown_stateUpdate() {
        
        viewModelDetail.didEndCountdown() // when
        XCTAssertEqual(viewModelDetail.socialState, .loading)
        // ProductDetailModel: var modifiedFlag: Bool = false, makes this test fail, changed it to true
    }
    
    func test_updateUserInterface_forStateSuccess_uponCurrentStateNotifiesViewToUpdateUI() {

        XCTAssertEqual(viewDetail.counter_updateUIForSuccessState, 0)
        viewModelDetail.updateUserInterface(for: .success) // when
        XCTAssertEqual(viewDetail.counter_updateUIForSuccessState, 1)
    }
    
    func test_updateUserInterface_forStateLoading_uponCurrentStateNotifiesViewToUpdateUI() {
        XCTAssertEqual(viewDetail.counter_updateUIForLoadingState, 0)
        viewModelDetail.updateUserInterface(for: .loading) // when
        XCTAssertEqual(viewDetail.counter_updateUIForLoadingState, 1)
    }
    
    func test_updateUserInterface_forStateError_uponCurrentStateNotifiesViewToUpdateUI() {
        XCTAssertEqual(viewDetail.counter_updateUIForErrorState, 0)
        viewModelDetail.updateUserInterface(for: .error(NSError())) // when
        XCTAssertEqual(viewDetail.counter_updateUIForErrorState, 1)
    }
    
    func test_setUpdatedSocial_stateUpdate() {
        viewModelDetail.setUpdatedSocial() // when
        XCTAssertEqual(viewModelDetail.socialState, .success)
    }
    // - End of - ProductDetail ViewModel
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // - Start of - ProductGallery ViewModel
    
    func test_viewDidLoad_invokesRequiredSequence() {
        // TODO: Complete Gallery Tests
    }
}
