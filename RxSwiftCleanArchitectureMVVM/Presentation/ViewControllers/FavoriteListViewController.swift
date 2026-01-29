//
//  FavoriteViewController.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/23/26.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteListViewController: UIViewController {
    var viewModel: RecipeListViewModelProtocol?
    private let disposeBag = DisposeBag()
    private let saveFavorite = PublishRelay<Recipe>()
    private let removeFavorite = PublishRelay<Int>()
    private let fetchMore = PublishRelay<Void>()
    
    @IBOutlet weak var favoriteListSearchBar: UISearchBar!
    @IBOutlet weak var favoriteListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func bindViewModel() {
        let query = favoriteListSearchBar.rx.text.orEmpty.debounce(.microseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel?.transform(input: RecipeListViewModel.Input(tabType: .just(.favorite), query: query, saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMore.asObservable()))
        
        output?.cellData.bind(to: favoriteListCollectionView.rx.items) { collectionView, index, item in
            return UICollectionViewCell()
        }.disposed(by: disposeBag)
        
        output?.error.bind { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(.init(title: "confirm", style: .default))
            self?.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
    
}

extension FavoriteListViewController: UICollectionViewDelegateFlowLayout {
    
}

extension FavoriteListViewController: UICollectionViewDelegate {
    
}

extension FavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteListCell", for: indexPath) as? FavoriteListCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
