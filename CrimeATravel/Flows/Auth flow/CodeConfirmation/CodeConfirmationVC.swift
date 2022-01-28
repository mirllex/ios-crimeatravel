//
//  CodeConfirmationVC.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 17.01.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class CodeConfirmationVC: BaseViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var centredContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var noCodeLabel: UILabel!
    @IBOutlet weak var noCodeButton: UIButton!
    @IBOutlet weak var continueButton: CTButton!
    @IBOutlet weak var numbersTextField: UITextField!
    @IBOutlet weak var numbersStackView: UIStackView!
    
    //MARK: Properties
    
    private let phone: String
    
    //MARK: Initialization
    
    init(phone: String) {
        self.phone = phone
        super.init(nibName: "CodeConfirmationVC", bundle: nil)
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
//        numbersTextField.becomeFirstResponder()
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        centredContentView.layer.cornerRadius = 24
        centredContentView.layer.cornerCurve = .continuous
        numbersTextField.delegate = self
        numbersTextField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        numbersStackView.arrangedSubviews.forEach { arrangedSubview in
            arrangedSubview.layer.borderWidth = 0.5
            arrangedSubview.layer.borderColor = UIColor(named: "secondaryTextColor")?.cgColor
            arrangedSubview.layer.cornerRadius = 8
            //arrangedSubview.layer.cornerCurve = .continuous
            (arrangedSubview.subviews.first as? UILabel)?.text = nil
        }
    }
    
    private func sendCodeConfirmationRequest() {
        guard let code = numbersTextField.text,
              code.count == 4
        else { return }
        numbersTextField.resignFirstResponder()
        continueButton.startLoading()
        let request = CodeConfirmationRequest(phone: phone, smsCode: code)
        CrimeATravelAPI.shared.codeConfirmation(request) { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                guard let self = self else { return }
                self.continueButton.stopLoading()
                switch result {
                case .success(let response):
                    Keychain.accessToken = response.data.accessToken
                    Defaults.isAuthorized = true
                    self.redirectToHome()
                case .failure(let error):
                    self.showError(error.localizedDescription)
                    self.numbersTextField.becomeFirstResponder()
                }
            }
        }
    }
    
    private func redirectToHome() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.showHome()
    }
    
    //MARK: Actions
    
    @IBAction func noCodeButtonTapped(_ sender: UIButton) {
        print("noCodeButtonTapped")
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        sendCodeConfirmationRequest()
    }
    
    @IBAction func textFieldValueChanged(_ textField: UITextField) {
        guard let text = textField.text,
              text.count <= numbersStackView.arrangedSubviews.count
        else { return }
        for i in 0..<4 {
            let label = numbersStackView.arrangedSubviews[i].subviews.first as? UILabel
            label?.text = (i < text.count) ? String(text[i]) : nil
        }
        if text.count == 4 {
            sendCodeConfirmationRequest()
        }
    }
}


//MARK: UITextFieldDelegate
extension CodeConfirmationVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if let char = string.cString(using: String.Encoding.utf8) {
          let isBackSpace = strcmp(char, "\\b")
          if (isBackSpace == -92) {
            return true
          }
        }
        
        return text.count != 4
    }
}
