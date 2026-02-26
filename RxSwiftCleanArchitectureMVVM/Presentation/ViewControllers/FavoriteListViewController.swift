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
    private let removeFavorite = PublishRelay<String>()
    private let fetchMore = PublishRelay<Void>()
    
    @IBOutlet weak var favoriteListSearchBar: UISearchBar!
    @IBOutlet weak var favoriteListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let query = favoriteListSearchBar.rx.text.orEmpty.debounce(.microseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel?.transform(input: RecipeListViewModel.Input(tabType: .just(.favorite), query: query, saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMore.asObservable()))
        
        output?.cellData.bind(to: favoriteListCollectionView.rx.items) { [weak self] collectionView, index, cellData in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCollectionViewCell", for: IndexPath(row: index, section: 0)) as? RecipeListCollectionViewCell else { return RecipeListCollectionViewCell() }
            
            cell.setup(cellData: cellData)
            
            if case let .recipe(recipe, isFavorite) = cellData {
                cell.favoriteButton.rx.tap.bind {
                    if isFavorite {
                        self?.removeFavorite.accept(recipe.recipeSequence)
                    } else {
                        self?.saveFavorite.accept(recipe)
                    }
                }.disposed(by: cell.disposeBag)
            }
            
            return cell
        }.disposed(by: disposeBag)
        
        output?.error.bind { errorMessage in
            print("favorite bindViewModel() Error Message:", errorMessage)
        }.disposed(by: disposeBag)
    }
    
    
}

extension FavoriteListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 5
        let width: CGFloat = (collectionView.bounds.width - spacing * 2) / 3
        let height: CGFloat = width + width / 2
        
        return CGSize(width: width, height: height)
    }
}
