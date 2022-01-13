//
//  UIViewController+Ex.swift
//  Theeye
//
//  Created by Murodjon Ibrohimov on 04.04.2021.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit
import AVFoundation
import ContactsUI

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showConfirmationAlert(title: String? = nil, message: String? = nil,
                               confirmTitle: String,
                               confirmStyle: UIAlertAction.Style = .default,
                               action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: confirmStyle, handler: action))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showCameraAccess(_ completion: @escaping (() -> Void)) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            self.showConfirmationAlert(
                title: "Camera",
                message: "We need access to your camera. Go to settings?",
                confirmTitle: "Settings")
            { _ in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
        case .authorized:
            completion()
        case .restricted, .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        @unknown default:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func showMicrophoneAccess(_ completion: @escaping (() -> Void)) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .denied:
            self.showConfirmationAlert(
                title: "Microhone",
                message: "We need access to your microphone. Go to settings?",
                confirmTitle: "Settings")
            { _ in
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
        case .granted:
            completion()
        default:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                if granted {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
    
    func showNotificationAccess() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: return
            case .denied:
                self.showConfirmationAlert(
                    title: "Notifications",
                    message: "You need enable notifications. Go to settings?",
                    confirmTitle: "Settings")
                { _ in
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(appSettings)
                    }
                }
            default:
                center.requestAuthorization(options:  [.alert, .sound, .badge]) { granted, error in
                    return
                }
            }
        }
    }
    
}
