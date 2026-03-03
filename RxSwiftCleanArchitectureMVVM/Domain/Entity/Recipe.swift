//
//  Recipe.swift
//  RxSwiftCleanArchitectureMVVM
//
//  Created by clapbin on 1/5/26.
//

import Foundation

public struct RecipeApiResult: Decodable {
    let cookRecipes: CookRecipes
    
    enum CodingKeys: String, CodingKey {
        case cookRecipes = "COOKRCP01"
    }
    
    init(cookRecipes: CookRecipes) {
        self.cookRecipes = cookRecipes
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cookRecipes = try container.decode(CookRecipes.self, forKey: .cookRecipes)
    }
}

public struct CookRecipes: Decodable {
    // 레시피 갯수
    let totalCount: String
    // 통신 결과
    let apiResult: ApiResult
    // 레시피들
    let recipes: [Recipe]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case apiResult = "RESULT"
        case recipes = "row"
    }
    
    init(totalCount: String, apiResult: ApiResult, recipes: [Recipe]?) {
        self.totalCount = totalCount
        self.apiResult = apiResult
        self.recipes = recipes
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(String.self, forKey: .totalCount)
        self.apiResult = try container.decode(ApiResult.self, forKey: .apiResult)
        self.recipes = try? container.decode([Recipe].self, forKey: .recipes)
    }
}

public struct ApiResult: Decodable {
    let code: String
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case message = "MSG"
    }
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
}

public struct Recipe: Decodable, Hashable {
    // 일련번호
    let recipeSequence: String
    // 메뉴명
    let recipeName: String
    // 재료
    let recipeParts: String?
    // 조리 방법
    let recipeWay: String?
    // 요리 종류
    let recipePat: String?
    // 중량(1인분)
    let infoWeight: String?
    // 열량
    let infoEnergy: String?
    // 탄수화물
    let infoCar: String?
    // 단백질
    let infoPro: String?
    // 지방
    let infoFat: String?
    // 나트륨
    let infoNa: String?
    // 대표 이미지(대)
    let bigMainImage: String?
    // 대표 이미지(소)
    let smallMainImage: String?
    // 저감 조리법
    let recipeNatTips: String?
    // 해시태그
    let hashTag: String?
    // 만드는법 01~20
    let manual01: String?
    let manual02: String?
    let manual03: String?
    let manual04: String?
    let manual05: String?
    let manual06: String?
    let manual07: String?
    let manual08: String?
    let manual09: String?
    let manual10: String?
    let manual11: String?
    let manual12: String?
    let manual13: String?
    let manual14: String?
    let manual15: String?
    let manual16: String?
    let manual17: String?
    let manual18: String?
    let manual19: String?
    let manual20: String?
    // 만드는 법 이미지 01~20
    let manualImg01: String?
    let manualImg02: String?
    let manualImg03: String?
    let manualImg04: String?
    let manualImg05: String?
    let manualImg06: String?
    let manualImg07: String?
    let manualImg08: String?
    let manualImg09: String?
    let manualImg10: String?
    let manualImg11: String?
    let manualImg12: String?
    let manualImg13: String?
    let manualImg14: String?
    let manualImg15: String?
    let manualImg16: String?
    let manualImg17: String?
    let manualImg18: String?
    let manualImg19: String?
    let manualImg20: String?
    
    enum CodingKeys: String, CodingKey {
        case recipeSequence = "RCP_SEQ"
        case recipeName = "RCP_NM"
        case recipeParts = "RCP_PRTS"
        case recipeWay = "RCP_WAY2"
        case recipePat = "RCP_PAT2"
        case infoWeight = "INFO_WGT"
        case infoEnergy = "INFO_ENG"
        case infoCar = "INFO_CAR"
        case infoPro = "INFO_PRO"
        case infoFat = "INFO_FAT"
        case infoNa = "INFO_NA"
        case bigMainImage = "ATT_FILE_NO_MK"
        case smallMainImage = "ATT_FILE_NO_MAIN"
        case recipeNatTips = "RCP_NA_TIP"
        case hashTag = "HASH_TAG"
        case manual01 = "MANUAL01"
        case manual02 = "MANUAL02"
        case manual03 = "MANUAL03"
        case manual04 = "MANUAL04"
        case manual05 = "MANUAL05"
        case manual06 = "MANUAL06"
        case manual07 = "MANUAL07"
        case manual08 = "MANUAL08"
        case manual09 = "MANUAL09"
        case manual10 = "MANUAL10"
        case manual11 = "MANUAL11"
        case manual12 = "MANUAL12"
        case manual13 = "MANUAL13"
        case manual14 = "MANUAL14"
        case manual15 = "MANUAL15"
        case manual16 = "MANUAL16"
        case manual17 = "MANUAL17"
        case manual18 = "MANUAL18"
        case manual19 = "MANUAL19"
        case manual20 = "MANUAL20"
        case manualImg01 = "MANUAL_IMG01"
        case manualImg02 = "MANUAL_IMG02"
        case manualImg03 = "MANUAL_IMG03"
        case manualImg04 = "MANUAL_IMG04"
        case manualImg05 = "MANUAL_IMG05"
        case manualImg06 = "MANUAL_IMG06"
        case manualImg07 = "MANUAL_IMG07"
        case manualImg08 = "MANUAL_IMG08"
        case manualImg09 = "MANUAL_IMG09"
        case manualImg10 = "MANUAL_IMG10"
        case manualImg11 = "MANUAL_IMG11"
        case manualImg12 = "MANUAL_IMG12"
        case manualImg13 = "MANUAL_IMG13"
        case manualImg14 = "MANUAL_IMG14"
        case manualImg15 = "MANUAL_IMG15"
        case manualImg16 = "MANUAL_IMG16"
        case manualImg17 = "MANUAL_IMG17"
        case manualImg18 = "MANUAL_IMG18"
        case manualImg19 = "MANUAL_IMG19"
        case manualImg20 = "MANUAL_IMG20"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recipeSequence = try container.decode(String.self, forKey: .recipeSequence)
        self.recipeName = try container.decode(String.self, forKey: .recipeName)
        self.recipeParts = try? container.decode(String.self, forKey: .recipeParts)
        self.recipeWay = try? container.decode(String.self, forKey: .recipeWay)
        self.recipePat = try? container.decode(String.self, forKey: .recipePat)
        self.infoWeight = try? container.decode(String.self, forKey: .infoWeight)
        self.infoEnergy = try? container.decode(String.self, forKey: .infoEnergy)
        self.infoCar = try? container.decode(String.self, forKey: .infoCar)
        self.infoPro = try? container.decode(String.self, forKey: .infoPro)
        self.infoFat = try? container.decode(String.self, forKey: .infoFat)
        self.infoNa = try? container.decode(String.self, forKey: .infoNa)
        self.bigMainImage = try? container.decode(String.self, forKey: .bigMainImage)
        self.smallMainImage = try? container.decode(String.self, forKey: .smallMainImage)
        self.recipeNatTips = try? container.decode(String.self, forKey: .recipeNatTips)
        self.hashTag = try? container.decode(String.self, forKey: .hashTag)
        self.manual01 = try? container.decode(String.self, forKey: .manual01)
        self.manual02 = try? container.decode(String.self, forKey: .manual02)
        self.manual03 = try? container.decode(String.self, forKey: .manual03)
        self.manual04 = try? container.decode(String.self, forKey: .manual04)
        self.manual05 = try? container.decode(String.self, forKey: .manual05)
        self.manual06 = try? container.decode(String.self, forKey: .manual06)
        self.manual07 = try? container.decode(String.self, forKey: .manual07)
        self.manual08 = try? container.decode(String.self, forKey: .manual08)
        self.manual09 = try? container.decode(String.self, forKey: .manual09)
        self.manual10 = try? container.decode(String.self, forKey: .manual10)
        self.manual11 = try? container.decode(String.self, forKey: .manual11)
        self.manual12 = try? container.decode(String.self, forKey: .manual12)
        self.manual13 = try? container.decode(String.self, forKey: .manual13)
        self.manual14 = try? container.decode(String.self, forKey: .manual14)
        self.manual15 = try? container.decode(String.self, forKey: .manual15)
        self.manual16 = try? container.decode(String.self, forKey: .manual16)
        self.manual17 = try? container.decode(String.self, forKey: .manual17)
        self.manual18 = try? container.decode(String.self, forKey: .manual18)
        self.manual19 = try? container.decode(String.self, forKey: .manual19)
        self.manual20 = try? container.decode(String.self, forKey: .manual20)
        self.manualImg01 = try? container.decode(String.self, forKey: .manualImg01)
        self.manualImg02 = try? container.decode(String.self, forKey: .manualImg02)
        self.manualImg03 = try? container.decode(String.self, forKey: .manualImg03)
        self.manualImg04 = try? container.decode(String.self, forKey: .manualImg04)
        self.manualImg05 = try? container.decode(String.self, forKey: .manualImg05)
        self.manualImg06 = try? container.decode(String.self, forKey: .manualImg06)
        self.manualImg07 = try? container.decode(String.self, forKey: .manualImg07)
        self.manualImg08 = try? container.decode(String.self, forKey: .manualImg08)
        self.manualImg09 = try? container.decode(String.self, forKey: .manualImg09)
        self.manualImg10 = try? container.decode(String.self, forKey: .manualImg10)
        self.manualImg11 = try? container.decode(String.self, forKey: .manualImg11)
        self.manualImg12 = try? container.decode(String.self, forKey: .manualImg12)
        self.manualImg13 = try? container.decode(String.self, forKey: .manualImg13)
        self.manualImg14 = try? container.decode(String.self, forKey: .manualImg14)
        self.manualImg15 = try? container.decode(String.self, forKey: .manualImg15)
        self.manualImg16 = try? container.decode(String.self, forKey: .manualImg16)
        self.manualImg17 = try? container.decode(String.self, forKey: .manualImg17)
        self.manualImg18 = try? container.decode(String.self, forKey: .manualImg18)
        self.manualImg19 = try? container.decode(String.self, forKey: .manualImg19)
        self.manualImg20 = try? container.decode(String.self, forKey: .manualImg20)
    }
    
    public init(recipeSequence: String, recipeName: String,
                recipeParts: String? = nil, recipeWay: String? = nil, recipePat: String? = nil, infoWeight: String? = nil, infoEnergy: String? = nil, infoCar: String? = nil, infoPro: String? = nil, infoFat: String? = nil, infoNa: String? = nil,
                bigMainImage: String?, smallMainImage: String?, recipeNatTips: String?, hashTag: String?,
                manual01: String? = nil, manual02: String? = nil, manual03: String? = nil, manual04: String? = nil, manual05: String? = nil, manual06: String? = nil, manual07: String? = nil, manual08: String? = nil, manual09: String? = nil, manual10: String? = nil, manual11: String? = nil, manual12: String? = nil, manual13: String? = nil, manual14: String? = nil, manual15: String? = nil, manual16: String? = nil, manual17: String? = nil, manual18: String? = nil, manual19: String? = nil, manual20: String? = nil,
                manualImg01: String? = nil, manualImg02: String? = nil, manualImg03: String? = nil, manualImg04: String? = nil, manualImg05: String? = nil, manualImg06: String? = nil, manualImg07: String? = nil, manualImg08: String? = nil, manualImg09: String? = nil, manualImg10: String? = nil, manualImg11: String? = nil, manualImg12: String? = nil, manualImg13: String? = nil, manualImg14: String? = nil, manualImg15: String? = nil, manualImg16: String? = nil, manualImg17: String? = nil, manualImg18: String? = nil, manualImg19: String? = nil, manualImg20: String? = nil) {
        self.recipeSequence = recipeSequence
        self.recipeName = recipeName
        self.recipeParts = recipeParts
        self.recipeWay = recipeWay
        self.recipePat = recipePat
        self.infoWeight = infoWeight
        self.infoEnergy = infoEnergy
        self.infoCar = infoCar
        self.infoPro = infoPro
        self.infoFat = infoFat
        self.infoNa = infoNa
        self.bigMainImage = bigMainImage
        self.smallMainImage = smallMainImage
        self.recipeNatTips = recipeNatTips
        self.hashTag = hashTag
        self.manual01 = manual01
        self.manual02 = manual02
        self.manual03 = manual03
        self.manual04 = manual04
        self.manual05 = manual05
        self.manual06 = manual06
        self.manual07 = manual07
        self.manual08 = manual08
        self.manual09 = manual09
        self.manual10 = manual10
        self.manual11 = manual11
        self.manual12 = manual12
        self.manual13 = manual13
        self.manual14 = manual14
        self.manual15 = manual15
        self.manual16 = manual16
        self.manual17 = manual17
        self.manual18 = manual18
        self.manual19 = manual19
        self.manual20 = manual20
        self.manualImg01 = manualImg01
        self.manualImg02 = manualImg02
        self.manualImg03 = manualImg03
        self.manualImg04 = manualImg04
        self.manualImg05 = manualImg05
        self.manualImg06 = manualImg06
        self.manualImg07 = manualImg07
        self.manualImg08 = manualImg08
        self.manualImg09 = manualImg09
        self.manualImg10 = manualImg10
        self.manualImg11 = manualImg11
        self.manualImg12 = manualImg12
        self.manualImg13 = manualImg13
        self.manualImg14 = manualImg14
        self.manualImg15 = manualImg15
        self.manualImg16 = manualImg16
        self.manualImg17 = manualImg17
        self.manualImg18 = manualImg18
        self.manualImg19 = manualImg19
        self.manualImg20 = manualImg20
    }
}
