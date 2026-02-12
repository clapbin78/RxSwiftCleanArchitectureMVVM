//
//  ViewController.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/2/26.
//

import UIKit
import RxSwift
import RxCocoa

class RecipeListViewController: UIViewController {
    var viewModel: RecipeListViewModelProtocol?
    private let disposeBag = DisposeBag()
    private let saveFavorite = PublishRelay<Recipe>()
    private let removeFavorite = PublishRelay<String>()
    private let fetchMore = PublishRelay<Void>()
    
    @IBOutlet weak var recipeListSearchBar: UISearchBar!
    @IBOutlet weak var recipeListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }

    private func bindViewModel() {
        let query = recipeListSearchBar.rx.text.orEmpty.debounce(.microseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel?.transform(input: RecipeListViewModel.Input(tabType: .just(.all), query: query, saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMore.asObservable()))
        
        output?.cellData.bind(to: recipeListCollectionView.rx.items) { collectionView, index, cellData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeListCollectionViewCell", for: IndexPath(row: index, section: 0)) as? RecipeListCollectionViewCell else { return RecipeListCollectionViewCell() }
            cell.setup(cellData: cellData)
            return cell
        }.disposed(by: disposeBag)
        
        output?.error.bind { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(.init(title: "confirm", style: .default))
            self?.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }

}

extension RecipeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 5
        let width: CGFloat = (collectionView.bounds.width - spacing * 2) / 3
        let height: CGFloat = width + width / 2
        
        return CGSize(width: width, height: height)
    }
}

extension RecipeListViewController: UICollectionViewDelegate {
    
}

extension RecipeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeListCell", for: indexPath) as? RecipeListCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}
