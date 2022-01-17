//
//  LoginVC.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 17.01.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {
    
    //MARK: Properties
    
    //MARK: Outlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: Initialization
    
    init() {
        super.init(nibName: "LoginVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.16),
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.48),
            UIColor(red: 1, green: 1, blue: 1, alpha: 1)
          ]
        
        view.applyGradient(
            colors: colors,
            locations: [0.11, 0.48, 0.9],
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint:  CGPoint(x: 0.5, y: 1))
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        contentView.layer.cornerRadius = 24
        contentView.layer.cornerCurve = .continuous
    }
    
    //MARK: Actions
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        navigationController?.pushViewController(CodeConfirmationVC(), animated: true)
    }
}
