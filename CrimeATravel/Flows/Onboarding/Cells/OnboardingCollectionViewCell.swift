//
//  OnboardingCollectionViewCell.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.01.22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    //MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: Instance Methods
    
    func configure(with type: OnboardingFlowTypes) {
        imageView.image = type.image
        titleLabel.text = type.title
        descriptionLabel.text = type.description
    }

}

enum OnboardingFlowTypes: CaseIterable {
    case first
    case second
    case third
    
    var image: UIImage? {
        switch self {
        case .first:  return UIImage(named: "onboarding.first")
        case .second: return UIImage(named: "onboarding.second")
        case .third:  return UIImage(named: "onboarding.third")
        }
    }
    
    var title: String {
        switch self {
        case .first:  return "Выберите город"
        case .second: return "Найдите места"
        case .third:  return "Настройте путешествие"
        }
    }
    
    var description: String {
        switch self {
        case .first:
           return "Путешествуйте по Крыму, смотрите достопримечательности и знакомьтесь с городом как местный житель"
        case .second:
            return "Предоставив приложению доступ к вашему местоположению значительно упростит поиск "
        case .third:
            return "Исследуйте места,сохраняйте достопримечательности и планируйте свой отдых"
        }
    }
}
