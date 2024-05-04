//
//  UIViewController+Ext.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 12.04.2024.
//
import UIKit

fileprivate var containerview : UIView!
extension UIViewController {
    func presentGFAlertOnMainThread(title : String,message : String,buttontitle : String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alerttitle: title, message: message, buttontitle: buttontitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    func showloadingview(){
        containerview = UIView(frame: view.bounds)
        view.addSubview(containerview)
        
        containerview.backgroundColor = .systemBackground
        containerview.alpha = 0
        UIView.animate(withDuration: 0.25) {
            containerview.alpha = 0.8
        }
        let activityindicator = UIActivityIndicatorView(style: .large)
        containerview.addSubview(activityindicator)
        activityindicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityindicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityindicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityindicator.startAnimating()
    }
    func dismissloadingview(){
        DispatchQueue.main.async {
            containerview.removeFromSuperview()
            containerview = nil
        }
       
    }
    func showemptystatesview(with message : String,in view : UIView){
        let emptystateview = GFEmpytStateView(message: message)
        emptystateview.frame = view.bounds
        view.addSubview(emptystateview)
    }
}
