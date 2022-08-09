//
//  ServerUrlViewController.swift
//  Detector
//
//  Created by Macbook on 27/07/2022.
//

import Foundation
import UIKit

class ServerUrlViewController: UIViewController {
    
    //MARK: - Section Name
    var closeButton: UIImageView = {
        let obj = UIImageView(image: UIImage(systemName: "xmark.app")?.withRenderingMode(.alwaysTemplate))
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.tintColor = .red
        obj.isUserInteractionEnabled = true
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    var headingLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.boldSystemFont(ofSize: 24)
        obj.numberOfLines = 1
        obj.textAlignment = .center
        obj.text = "Enter Server URL:"
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        return obj
    }()
    
    var serverUrlTextField: UITextField = {
        let obj = UITextField()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .silverGray
        obj.font = UIFont.systemFont(ofSize: 18)
        obj.placeholder = "https://"
        obj.textAlignment = .center
        obj.text = DetectorUserDefaults.serverUrl
        obj.layer.cornerRadius = 12
        return obj
    }()
    
    var saveButton: UIButton = {
        let obj = UIButton()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.setTitle("Save", for: .normal)
        obj.setTitleColor(.white, for: .normal)
        obj.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        obj.backgroundColor = .themeBlue
        obj.layer.cornerRadius = 12
        return obj
    }()
    
    //MARK: - Section Name
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Section Name
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
//        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        let closeGesture = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        closeButton.addGestureRecognizer(closeGesture)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(gesture)
        
        view.addSubview(closeButton)
        view.addSubview(headingLabel)
        view.addSubview(serverUrlTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            headingLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -52),
            
            serverUrlTextField.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            serverUrlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            serverUrlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            serverUrlTextField.heightAnchor.constraint(equalToConstant: 50),
            
            saveButton.topAnchor.constraint(equalTo: serverUrlTextField.bottomAnchor, constant: 60),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        ])
    }
    
    @objc func didTapSave() {
        guard let url = serverUrlTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              url != "" else {
                  return
              }
        
        DetectorUserDefaults.serverUrl = url
        dismiss(animated: true)
    }
    
    @objc func didTapView() {
        view.endEditing(true)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
}
