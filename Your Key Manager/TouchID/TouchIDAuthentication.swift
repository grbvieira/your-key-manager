//
//  TouchIDAuthentication.swift
//  Your Key Manager
//
//  Created by Danilo Henrique on 24/06/18.
//  Copyright © 2018 Danilo Henrique. All rights reserved.
//

import LocalAuthentication

class BiometricIDAuth{
    static let shared = BiometricIDAuth()
    
    private init(){}
    
    private let context = LAContext()
    private var loginReason = "Logging in with Touch ID"
    
    func isBiometricIDSupported() -> Bool{
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: loginReason) { [unowned self] (success, error) in
            self.registerUserAuthentication()
            completion(success, error)
        }
    }
    
    func getTouchIDErrorMessage(_ error: Error) -> String{
        let error = error as! LAError
        
        let message: String
        switch error {

        case LAError.authenticationFailed:
            message = "Aconteceu um problema verificando sua identidade"
        case LAError.userCancel:
            message = "Botão de Cancelar pressionado."
        case LAError.userFallback:
            message = "Botão de senha pressionado "
        case LAError.biometryNotAvailable:
            message = "Touch ID não está disponível"
        case LAError.biometryNotEnrolled:
            message = "Touch ID não está configurado"
        case LAError.biometryLockout:
            message = "Touch ID está desativado"
        default:
            message = "Touch ID precisa ser configurado"
        }
        return message
    }

    func registerUserAuthentication() {
         UserDefaults.standard.setValue(true, forKey: "TouchIDIsAuthenticated")
    }
    
    func userAlreadyAuthenticated() -> Bool{
        let TouchIDIsAuthenticated = UserDefaults.standard.bool(forKey: "TouchIDIsAuthenticated")
        return TouchIDIsAuthenticated
    }
}


































