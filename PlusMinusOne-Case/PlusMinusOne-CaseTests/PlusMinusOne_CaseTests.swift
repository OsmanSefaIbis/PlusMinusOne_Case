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
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // - Start of - ProductDetail ViewModel
    func test_viewDidLoad_invokesSetupAndConfigurationOfUserInterface() {
        XCTAssertEqual(viewDetail.counter_setupUserInterface, 0)
        XCTAssertEqual(viewDetail.counter_configureUserInterface, 0)
        viewModelDetail.viewDidLoad()
        XCTAssertEqual(viewDetail.counter_setupUserInterface, 1)
        XCTAssertEqual(viewDetail.counter_configureUserInterface, 1)
    }
    
    func test_getData_whenDataAvailable() {
        
        let mockDataWannaBe: DetailData? = .init(
            id: 1,
            productBrand: "Brand Name",
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
    
    func test_getData_whenDataNotAvailable() {
        
        let result = viewModelDetail.getData(.productBrand) as? String // when
        XCTAssertNil(result)
    }
    
    func test_getLatestSocial_whenLatestUpdatedSocialAvailable() {
        let mockDataWannaBe: Social = .init(likeCount: 1, commentCounts: CommentInfo(averageRating: 1.0, anonymousCommentsCount: 1, memberCommentsCount: 1))
        
        viewModelDetail.latestUpdatedSocial = mockDataWannaBe
        let result = viewModelDetail.getLatestSocial() // when
        
        XCTAssertEqual(result?.likeCount, 1)
        XCTAssertEqual(result?.commentCounts?.averageRating, 1.0)
        XCTAssertEqual(result?.commentCounts?.anonymousCommentsCount, 1)
        XCTAssertEqual(result?.commentCounts?.memberCommentsCount, 1)
        
    }
    
    func test_getLatestSocial_whenLatestUpdatedSocialUnavailable() {
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
        XCTAssertEqual(viewGallery.counter_setupUserInterface, 0)
        XCTAssertEqual(viewGallery.counter_setupDelegates, 0)
        viewModelGallery.viewDidLoad() // when
        XCTAssertEqual(viewGallery.counter_setupUserInterface, 1)
        XCTAssertEqual(viewGallery.counter_setupDelegates, 1)
    }
    
    func test_getItem_whenAvailableAtIndexpath() {
        let item1 = RowItem(id: 1, productBrand: "Brand1", productType: "Type1", imageUrl: "Image1", priceInfo: Price(value: 10, currency: "USD"), currentSocialFeed: nil)
        let item2 = RowItem(id: 2, productBrand: "Brand2", productType: "Type2", imageUrl: "Image2", priceInfo: Price(value: 20, currency: "EUR"), currentSocialFeed: nil)

        viewModelGallery.items = [item1, item2]

        let indexPath1 = IndexPath(item: 0, section: 0)
        let indexPath2 = IndexPath(item: 1, section: 0)

        let resultItem1 = viewModelGallery.getItem(at: indexPath1) // when
        let resultItem2 = viewModelGallery.getItem(at: indexPath2)

        XCTAssertEqual(resultItem1?.id, item1.id)
        XCTAssertEqual(resultItem2?.id, item2.id)
    }
    
    func test_getItem_whenUnavailable() {
        let item1 = RowItem(id: 1, productBrand: "Brand1", productType: "Type1", imageUrl: "Image1", priceInfo: Price(value: 10, currency: "USD"), currentSocialFeed: nil)
        let item2 = RowItem(id: 2, productBrand: "Brand2", productType: "Type2", imageUrl: "Image2", priceInfo: Price(value: 20, currency: "EUR"), currentSocialFeed: nil)

        viewModelGallery.items = [item1, item2]

        let indexPath1 = IndexPath(item: 0, section: 0)
        let indexPath2 = IndexPath(item: 2, section: 0) // Out of bounds

        let resultItem1 = viewModelGallery.getItem(at: indexPath1) // when
        let resultItem2 = viewModelGallery.getItem(at: indexPath2)

        XCTAssertEqual(resultItem1?.id, item1.id)
        XCTAssertNil(resultItem2)
    }
    
    func test_didSelectItem_routesToDetail() {
        let item = RowItem(id: 1, productBrand: "Brand1", productType: "Type1", imageUrl: "Image1", priceInfo: Price(value: 10, currency: "USD"), currentSocialFeed: nil)

        viewModelGallery.items = [item]
        let indexPath = IndexPath(item: 0, section: 0)

        viewModelGallery.didSelectItem(at: indexPath) // when
        
        let resultItem = viewModelGallery.getItem(at: indexPath)

        XCTAssertTrue(viewGallery.flag_navigateToDetail)
        XCTAssertEqual(resultItem?.id, item.id)
    }
    
    func test_updateUserInterface_gridPreference_collectionViewDisplaysAsGrid() {
        
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToGrid, 0)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 0)
        viewModelGallery.updateColumnPreference(by: 2) // when
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToGrid, 1)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 1)
    }
    
    func test_updateUserInterface_singularPreference_collectionViewDisplaysAsSingular() {
        
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToSingular, 0)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 0)
        viewModelGallery.updateColumnPreference(by: 1) // when
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToSingular, 1)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 1)
    }
    
    func test_updateUserInterface_someOtherPreference_collectionViewDisplaysPriorSet() {
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToSingular, 0)
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToGrid, 0)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 0)
        viewModelGallery.updateColumnPreference(by: 99) // when
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToSingular, 0)
        XCTAssertEqual(viewGallery.counter_setNavigationBarItemToGrid, 0)
        XCTAssertEqual(viewGallery.counter_reloadCollectionView, 1)
    }
    
    // - End of - ProductGallery ViewModel
}
