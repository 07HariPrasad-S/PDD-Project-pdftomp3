//
//  UIViewController.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 13/02/25.
//
import UIKit
import NVActivityIndicatorView

extension UIViewController {
    func popUpAlert(title: String, message: String, actionTitles: [String], actionStyle: [UIAlertAction.Style], action: @escaping ([UIAlertAction]) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var alertActions = [UIAlertAction]()
        for (_, actionTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: actionTitle, style: actionStyle[0], handler: { _ in
                action(alertActions)
            })
            alertActions.append(action)
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
     func showAlertWithCompletion(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
     func showAlertWithOptionsAndCompletion(title: String, message: String,alertAction1: String = "OK", alertAction2: String = "Cancel", completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: alertAction1, style: .default) { _ in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: alertAction2, style: .cancel) { _ in
            completion(false)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
     func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

extension UIView {
    private static var loaderView: UIView?
    
    func startLoader() {
        if UIView.loaderView != nil {
            return
        }
        let loaderView = UIView(frame: self.bounds)
        //loaderView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.addSubview(loaderView)
        let loader = NVActivityIndicatorView(frame: CGRect(x: 0, y: 20, width: 60, height: 60), type: .ballClipRotateMultiple, color: UIColor(hex: "#6EA7F1"))
        loader.center = loaderView.center
        loaderView.addSubview(loader)
        loader.startAnimating()
        UIView.loaderView = loaderView
    }
    
    func startSplashLoader() {
        if UIView.loaderView != nil {
            return
        }
        
        // Create a loader view that covers the entire screen
        let loaderView = UIView(frame: self.bounds)
        self.addSubview(loaderView)
        
        // Create the NVActivityIndicatorView and set its position to the bottom center
        let loaderSize: CGFloat = 60
        let loaderYPosition = self.bounds.height - loaderSize - 50 // 50 points from the bottom
        let loaderFrame = CGRect(x: (self.bounds.width - loaderSize) / 2, y: loaderYPosition, width: loaderSize, height: loaderSize)
        let loader = NVActivityIndicatorView(frame: loaderFrame, type: .lineScale, color: UIColor(hex: "#6EA7F1"))
        
        loaderView.addSubview(loader)
        loader.startAnimating()
        
        // Set the loaderView to the UIView's loaderView property
        UIView.loaderView = loaderView
    }

    
    func startLoaderInButton() {
        if UIView.loaderView != nil {
            return
        }
        let loaderView = UIView(frame: self.bounds)
        //loaderView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.addSubview(loaderView)
        let loader = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25), type: .ballPulseSync, color: .white)
        loader.center = loaderView.center
        loaderView.addSubview(loader)
        loader.startAnimating()
        UIView.loaderView = loaderView
    }
    
    func stopLoader() {
        DispatchQueue.main.async {
            UIView.loaderView?.removeFromSuperview()
            UIView.loaderView = nil
        }
    }
}
