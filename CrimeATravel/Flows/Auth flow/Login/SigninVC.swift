//
//  LoginVC.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 17.01.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class SigninVC: BaseViewController {
    
    //MARK: Properties
    
    //MARK: Outlets
    
    @IBOutlet weak var centredContenttView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var continueButton: CTButton!
    
    //MARK: Initialization
    
    init() {
        super.init(nibName: "SigninVC", bundle: nil)
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
        centredContenttView.layer.cornerRadius = 24
        centredContenttView.layer.cornerCurve = .continuous
    }
    
    private func sendSigninRequest() {
        guard let phone = phoneTextField.text,
              phone.count > 8
        else {
            showError("Неверный формат номера!")
            return
        }
        continueButton.startLoading()
        let request = SignInRequest(phone: phone)
        CrimeATravelAPI.shared.signIn(request) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                guard let self = self else { return }
                self.continueButton.stopLoading()
                switch result {
                case .success(_):
                    self.view.endEditing(true)
                    let codeVC = CodeConfirmationVC(phone: phone)
                    self.navigationController?.pushViewController(codeVC, animated: true)
                case .failure(let error):
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: Actions
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        sendSigninRequest()
    }
}
