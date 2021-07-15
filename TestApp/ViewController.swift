//
//  ViewController.swift
//  TestApp
//
//  Created by Roman Muzikantov on 11/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mDescriptionLabel: UILabel!
    @IBOutlet weak var mLoginLabel: UILabel!
    @IBOutlet weak var mPasswordLabel: UILabel!
    @IBOutlet weak var mConfirmButton: UIButton!
    @IBOutlet weak var mPasswordTextField: UITextField!
    
    var isConnecting: Bool = false {
        didSet {
            //mConfirmButton.setNeedsUpdateConfiguration()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mDescriptionLabel.text = "Connectez-vous pour vous fabriquer le burger de vos rêves."
        mLoginLabel.text = "Login"
        mPasswordLabel.text = "Mot de passe"
        view.backgroundColor = .backgroundColor
        
        mConfirmButton.configurationUpdateHandler = {
            [unowned self] button in
            //setButtonConfiguration()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /*view.keyboardLayoutGuide.topAnchor.constraint(equalTo: mConfirmButton.bottomAnchor, constant: 15).isActive = true*/
    }

    private func setButtonConfiguration() {
        
        var config = mConfirmButton.configuration
        
        if !isConnecting {
            config = .filled()
            config?.title = "Se connecter"
            config?.subtitle = "Sign in"
            config?.titleAlignment = .center
            config?.buttonSize = .large
            config?.baseBackgroundColor = .systemBlue
        } else {
            config?.showsActivityIndicator = true
            config?.imagePadding = 15
            config?.title = "Connexion..."
            config?.subtitle = ""
            config?.baseBackgroundColor = .lightGray
        }
        
        mConfirmButton.configuration = config
    }
    
    @IBAction func didTapConnectButton(sender: UIButton?) {
        isConnecting = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isConnecting = false
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: SecondViewController.identifier) as! SecondViewController
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

