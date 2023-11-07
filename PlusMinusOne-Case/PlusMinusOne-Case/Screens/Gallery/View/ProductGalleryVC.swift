//
//  ViewController.swift
//  PlusMinusOne-Case
//
//  Created by Sefa İbiş on 2.11.2023.
//

import UIKit

// - Class Contract
protocol ContractForProductGalleryVC: AnyObject {
    
    func setupUserInterface()
    func setupDelegates()
    func reloadCollectionView()
    func navigateToDetail(pass data: DetailData)
}

final class ProductGalleryVC: UIViewController {
    
    // - MVVM Variables
    private lazy var viewModel = ProductGalleryVM(view: self)
    
    // Life-cycle: Object
    init(){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Life-cycle: View
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // - User Interface Variables
    
    private let containerView: UIView = {
       let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
}

// - Contract Conformance
extension ProductGalleryVC: ContractForProductGalleryVC {
    
    func setupUserInterface() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setupContainerView()
        setupCollectionView()
    }
    
    func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func navigateToDetail(pass data: DetailData) {
        let detailPage = ProductDetailVC(data: data )
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
}

// - MVVM Notify Methods
extension ProductGalleryVC: DelegateOfProductGalleryVM {
    
    func didLoadProducts() {
        // TODO: Reload CollectionView
        // TODO: Think Additional Stuff
    }
    func didLoadSocialFeed() {
        // TODO: Think Later
    }
}

// - Helper Class Methods
extension ProductGalleryVC {
    
    func setupContainerView() {
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setupCollectionView() {
        
        containerView.addSubview(collectionView)
        let inset: CGFloat = 5
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: inset),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -inset),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: inset),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -inset)
        ])
    }
}
// - CollectionView DataSource Methods
extension ProductGalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell
        else { fatalError("Failed to dequeue cell for CollectionView in ProductGalleryVC") } // TODO: Localize Enum
        guard let data = viewModel.getItem(at: indexPath)
        else { fatalError("Failed to retrieve data.") } // TODO: Localize Enum
        cell.configureCell(with: data)
        return cell
    }
}

// - CollectionView Delegate Methods
extension ProductGalleryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
}
// - CollectionView Flow Layout Delegate Methods
extension ProductGalleryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() } // FIXME: Return
        
        let totalWidth = collectionView.bounds.width
        let totalInsetSpace = (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
        let totalCellSpacing = (CGFloat(viewModel.columnPreference - 1) * flowLayout.minimumInteritemSpacing)
        let availableWidthForCells = (totalWidth - totalInsetSpace - totalCellSpacing)
        let cellSizingValue = (availableWidthForCells / CGFloat(viewModel.columnPreference)) / 3
        let cellSize = CGSize(width: (cellSizingValue * 3), height: (cellSizingValue * 2)) // - Aspect Ratio: width/height = 3/2
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let defaultInset: UIEdgeInsets = .init(top: 5, left: 5, bottom: 0, right: 5)
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return defaultInset }
        flowLayout.sectionInset = defaultInset
        return flowLayout.sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let defaultSpacing: CGFloat = 5.0
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return defaultSpacing }
        flowLayout.minimumInteritemSpacing = defaultSpacing
        return flowLayout.minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let defaultSpacing: CGFloat = 5.0
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return defaultSpacing }
        flowLayout.minimumLineSpacing = defaultSpacing
        return flowLayout.minimumLineSpacing
    }

}

