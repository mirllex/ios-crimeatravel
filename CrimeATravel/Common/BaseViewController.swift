//
//  BaseViewController.swift
//  CrimeATravel
//
//  Created by Murodjon Ibrohimov on 22.05.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

protocol BaseViewDelegate {
    func startLoading()
    func stopLoading()
    func showError(_ error: String, cancelHandler: ((UIAlertAction) -> Void)?)
    func showSuccess(_ message: String, cancelHandler: ((UIAlertAction) -> Void)?)
}

extension BaseViewDelegate {
    func showError(_ error: String, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        self.showError(error, cancelHandler: cancelHandler)
    }
    func showSuccess(_ message: String, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        self.showSuccess(message, cancelHandler: cancelHandler)
    }
}

class BaseViewController: UIViewController {
    
    // MARK: Properties.
//    override var hidesBottomBarWhenPushed: Bool {
//        get {
//            let rootVC = navigationController?.topViewController
//            return !(rootVC is HomeViewController ||
//                        rootVC is CategoriesViewController ||
//                        rootVC is HelpViewController)
//        }
//        set {
//            super.hidesBottomBarWhenPushed = newValue
//        }
//    }
    
    // MARK: UI variables.
    lazy var loadingView: LoadingViewController = {
        let vc = LoadingViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }()
    
    lazy var emptyView: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }()
    
    // MARK: Instance methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !isBeingPresented {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.window?.backgroundColor = .white
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isBeingPresented {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.window?.backgroundColor = .clear
        }
    }
    
    func commonInit() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func pushToWebView(with title: String? = nil,
                       urlString: String? = nil,
                       bodyString: String? = nil) {
        let webVC = WebViewController(url: urlString, body: bodyString)
        webVC.title = title
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    func setTouchesEnable(_ enable: Bool, completion: (() -> Void)? = nil) {
        if !enable {
            present(emptyView, animated: false, completion: completion)
        } else if !emptyView.presentingViewController.isNil {
            dismiss(animated: false, completion: completion)
        }
    }

}

// MARK: BaseViewDelegate.
extension BaseViewController: BaseViewDelegate {
    
    @objc
    func startLoading() {
        loadingView.present(at: self)
    }
    
    @objc
    func stopLoading() {
        loadingView.dismiss()
    }
    
    @objc
    func showError(_ error: String, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Hide", style: .cancel, handler: cancelHandler))
        if presentedViewController === loadingView || presentedViewController === emptyView {
            dismiss(animated: true) { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    func showSuccess(_ message: String, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Hide", style: .cancel, handler: cancelHandler))
        if presentedViewController === loadingView || presentedViewController === emptyView {
            dismiss(animated: true) { [weak self] in
                self?.present(alert, animated: true, completion: nil)
            }
        } else {
            present(alert, animated: true, completion: nil)
        }
    }
}
