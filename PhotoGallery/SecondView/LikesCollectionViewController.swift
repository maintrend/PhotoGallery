//
//  LikesCollectionViewController.swift
//  PhotoGallery
//
//  Created by talgat on 6/26/21.
//

import UIKit


class LikesCollectionViewController: UICollectionViewController {

    var photos = [UnsplashPhoto]()
    
    private var selectedImages = [UIImage]()
    
    private var trashBarButtonItem: UIBarButtonItem = {
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        return trash
    }()
    
    private let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "You haven't add a photos yet"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var numberOfSelectedPhotos: Int {
        return collectionView.indexPathsForSelectedItems?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupCollectionView()
        setupEnterLabel()
        setupNavigationBar()

    }
    
    private func updateNavButtonState() {
        trashBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }
    
    @objc private func trashTapped() {
//        self.collectionView.deleteItemsAtIndexPaths([indexPath.item])
        self.collectionView.reloadData()
    }
    
    // MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(LikesCollectionViewCell.self, forCellWithReuseIdentifier: LikesCollectionViewCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.allowsMultipleSelection = true
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
    }
    
    private func setupEnterLabel() {
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel(text: "FAVOURITES", font: .systemFont(ofSize: 15, weight: .medium), textColor: #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        navigationItem.rightBarButtonItem = trashBarButtonItem
        trashBarButtonItem.isEnabled = false
    }
    
    // MARK: - Datasource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = photos.count != 0
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesCollectionViewCell.reuseId, for: indexPath) as! LikesCollectionViewCell
        let unsplashPhoto = photos[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateNavButtonState()
        let cell = collectionView.cellForItem(at: indexPath) as! LikesCollectionViewCell
        guard let image = cell.myImageView.image else {return}
        selectedImages.append(image)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateNavButtonState()
        let cell = collectionView.cellForItem(at: indexPath) as! LikesCollectionViewCell
        guard let image = cell.myImageView.image  else {return}
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}

    // MARK: - DelegateFlowLayout
extension LikesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
