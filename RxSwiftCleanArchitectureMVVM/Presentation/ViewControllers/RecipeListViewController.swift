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
        
        bindView()
        bindViewModel()
    }

    private func bindViewModel() {
        let query = recipeListSearchBar.rx.text.orEmpty.debounce(.microseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel?.transform(input: RecipeListViewModel.Input(tabType: .just(.all), query: query, saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMore.asObservable()))
        
        output?.cellData.bind(to: recipeListCollectionView.rx.items) { [weak self] collectionView, index, cellData in
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
            print("bindViewModel() Error Message:", errorMessage)
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        recipeListCollectionView.rx.prefetchItems
            .bind { [weak self] indexPaths in
                guard let self = self else { return }
                
                let totalItems = self.recipeListCollectionView.numberOfItems(inSection: 0)
                guard totalItems > 0 else { return }
                
                // 1. prefetch로 들어온 인덱스 중 가장 큰 값 찾기
                guard let maxRequestedIndex = indexPaths.map({ $0.item }).max() else { return }
                
                // 2. Threshold(여유분)를 1화면 분량(18개) 또는 최소 4~5줄(12~15개)로 넉넉히 설정
                let threshold = 18
                
                // 3. 현재 스크롤 위치가 끝에서 1화면 분량(18개) 정도 남았을 때 미리 다음 페이지 요청
                if maxRequestedIndex >= totalItems - threshold {
                    self.fetchMore.accept(())
                }
            }
            .disposed(by: disposeBag)
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
