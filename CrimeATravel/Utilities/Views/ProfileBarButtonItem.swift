//
//  ProfileBarButtonItem.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 1.12.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

final class ProfileBarButtonItem: UIBarButtonItem {
    
    let button = UIButton(type: .system)
    let label = UILabel()
    
    override init() {
        super.init()
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.layer.cornerRadius = 15
        button.layer.cornerCurve = .circular
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .systemGray4
        let image = AppCache.shared.zoomerProfileImage?
            .resizeImage(to: button.frame.size)
        button.setBackgroundImage(image, for: .normal)

        label.text = Defaults.zoomerProfile?.initials
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        label.isHidden = !image.isNil
        self.customView = button
    }
}
