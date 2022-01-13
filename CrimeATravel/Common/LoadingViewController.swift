//
//  LoadingViewController.swift
//  Theeye
//
//  Created by Murodjon Ibrohimov on 9.06.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit
import SnapKit

final class LoadingViewController: UIViewController {
    
    lazy var spinnerContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray3
        container.layer.cornerRadius = 10
        container.layer.cornerCurve = .continuous
        view.addSubview(container)
        return container
    }()
    
//    lazy var spinner: UIActivityIndicatorView = {
//        let spinner = UIActivityIndicatorView(style: .large)
//        spinner.color = .white
//        spinnerContainer.addSubview(spinner)
//        return spinner
//    }()
    
    lazy var spinner: CustomSpinnerView = {
        let spinner = CustomSpinnerView(radius: 22, color: .white)
        spinnerContainer.addSubview(spinner)
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        spinner.startAnimating()
    }
    
    private func makeConstraints() {
        
        spinnerContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(72)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    func present(at vc: UIViewController) {
        if presentingViewController.isNil {
            vc.present(self, animated: false, completion: nil)
        }
    }
    
    func dismiss() {
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
}

