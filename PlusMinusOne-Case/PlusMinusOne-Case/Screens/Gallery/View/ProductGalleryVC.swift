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
    func setNavigationBarItemToSingular()
    func setNavigationBarItemToGrid()
}

final class ProductGalleryVC: UIViewController {
    
    // - MVVM Variables
    private lazy var viewModel: ContractForProductGalleryVM = ProductGalleryVM(view: self)

    // - Life-cycle: Object
    init(){
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // - Life-cycle: View
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
        cv.accessibilityIdentifier = Localize.identifierCollectionView.raw()
        cv.backgroundColor = .systemBackground
        cv.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    private var buttonSingular = UIBarButtonItem()
    private var buttonGrid = UIBarButtonItem()
}

// - Contract Conformance
extension ProductGalleryVC: ContractForProductGalleryVC {
    
    func setupUserInterface() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.tintColor = .systemGray2
        updateNavigationBarItemButtons()
        viewModel.updateColumnPreference(by: viewModel.columnPreference)
        setupContainerView()
        setupCollectionView()
    }
    
    func setupDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
    func navigateToDetail(pass data: DetailData) {
        let detailPage = ProductDetailVC(data: data)
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    
    func setNavigationBarItemToSingular() {
        buttonSingular = UIBarButtonItem(image: UIImage(systemName: "square.split.1x2.fill"), style: .plain, target: self, action: #selector(tappedSingularButton))
        buttonGrid = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2"), style: .plain, target: self, action: #selector(tappedGridButton))
        updateNavigationBarItemButtons()
    }
    
    func setNavigationBarItemToGrid() {
        buttonGrid = UIBarButtonItem(image: UIImage(systemName: "square.grid.2x2.fill"), style: .plain, target: self, action: #selector(tappedGridButton))
        buttonSingular = UIBarButtonItem(image: UIImage(systemName: "square.split.1x2"), style: .plain, target: self, action: #selector(tappedSingularButton))
        updateNavigationBarItemButtons()
    }
}

// - MVVM Notify Methods
extension ProductGalleryVC: DelegateOfProductGalleryVM {
    
    func didLoadProducts() {
        // Not in scope.
    }
    func didLoadSocialFeed() {
        // Not in scope.
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
    @objc func tappedSingularButton() {
        viewModel.updateColumnPreference(by: 1)
    }
    @objc func tappedGridButton() {
        viewModel.updateColumnPreference(by: 2)
    }
    func updateNavigationBarItemButtons() {
        navigationItem.rightBarButtonItems = [buttonGrid, buttonSingular]
    }
}
// - CollectionView DataSource Methods
extension ProductGalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell
        else { fatalError(Localize.fatalDequeueCellPrompt.raw()) }
        guard let data = viewModel.getItem(at: indexPath)
        else { fatalError(Localize.getItemFailPrompt.raw()) }
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
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        
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

