//
//  HomeViewController.swift
//  Your Key Manager
//
//  Created by Danilo Henrique on 23/06/18.
//  Copyright © 2018 Danilo Henrique. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logOutBarButton: UIBarButtonItem!
    
    let viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if viewModel.needsToAuthenticateTouchID(){
            registerBiometricAuth()
        }
        
        setupReactiveBinds()
    }
    
    func setupReactiveBinds() {
        logOutBarButton.rx.tap.bind { [unowned self] in
            let loginNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginNavigationController")
            self.show(loginNavigationController, sender: nil)
        }.disposed(by: disposeBag)
    }
 
    func registerBiometricAuth(){
        
        BiometricIDAuth.shared.authenticateUser { (sucess, error) in
            if sucess{
                print("TOUCH ID CADASTRADO")
            }
        }
    }
    
    func showUserCredentials() {
        let credentials = viewModel.getWebsiteCredentials()
    }

    
}
