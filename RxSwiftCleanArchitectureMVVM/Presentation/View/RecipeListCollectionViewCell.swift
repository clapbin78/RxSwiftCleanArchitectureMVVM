//
//  RecipeListCollectionViewCell.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/29/26.
//

import UIKit
import Kingfisher
import RxSwift

final class RecipeListCollectionViewCell: UICollectionViewCell {
    public var disposeBag = DisposeBag()
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    func setup(cellData: RecipeListCellData) {
        guard case let .recipe(recipe, isFavorite) = cellData else { return }
        thumbnailImageView.kf.setImage(with: URL(string: (recipe.smallMainImage?.replacingOccurrences(of: "http://", with: "https://") ?? recipe.bigMainImage?.replacingOccurrences(of: "http://", with: "https://")) ?? ""))
        recipeName.text = recipe.recipeName
        favoriteButton.isSelected = isFavorite
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
