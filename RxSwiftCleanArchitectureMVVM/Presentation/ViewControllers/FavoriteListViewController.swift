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
    @IBOutlet weak var favoriteListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func bindViewModel() {
        let query = favoriteListSearchBar.rx.text.orEmpty.debounce(.microseconds(300), scheduler: MainScheduler.instance)
        let output = viewModel?.transform(input: RecipeListViewModel.Input(tabType: .just(.favorite), query: query, saveFavorite: saveFavorite.asObservable(), removeFavorite: removeFavorite.asObservable(), fetchMoreRecipeList: fetchMore.asObservable()))
        
        output?.cellData.bind(to: favoriteListTableView.rx.items) { tableView, index, item in
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        output?.error.bind { [weak self] errorMessage in
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(.init(title: "confirm", style: .default))
            self?.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
    
}
