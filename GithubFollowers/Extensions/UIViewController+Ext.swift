//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 12.04.2024.
//
import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title : String,message : String,buttontitle : String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alerttitle: title, message: message, buttontitle: buttontitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
