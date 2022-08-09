//
//  ViewController.swift
//  Detector
//
//  Created by Macbook on 26/07/2022.
//

import UIKit
import AVKit
import Lottie

class HomeViewController: UIViewController {

    var changeUrlButtonContainer: UIView = {
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
//        obj.backgroundColor = .darkGray
//        obj.layer.cornerRadius = 12
        return obj
    }()
    
//    var changeUrlButton: LeadingImageLabelView = {
//        let obj = LeadingImageLabelView(imageName: "url", labelText: "Url", labelcolor: .white, labelLines: 1, font: .boldSystemFont(ofSize: 24), spacing: 12)
//        obj.translatesAutoresizingMaskIntoConstraints = false
//        obj.leadingImageView.image = UIImage(named: "url")?.withRenderingMode(.alwaysTemplate)
//        obj.leadingImageView.tintColor = .white
//        obj.adjustImageToCenterY()
//        return obj
//    }()
    
    var changeUrlButton: UIImageView =
    {
        let obj = UIImageView(image: UIImage(systemName: "gear")?.withRenderingMode(.alwaysTemplate))
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.tintColor = .black
        obj.contentMode = .scaleAspectFit
        obj.isUserInteractionEnabled = true
        return obj
    }()
    
    var serverUrlLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: 14)
        obj.numberOfLines = 0
        obj.textAlignment = .center
        return obj
    }()
    
    var mainAnimationView: AnimationView =
    {
        let obj = AnimationView(name: "homeAnim")
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.contentMode = .scaleAspectFit
        obj.loopMode = .loop
        return obj
    }()
    
    var detectUsingLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.font = UIFont.systemFont(ofSize: 17)
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.text = "Detect using:"
        obj.textColor = .lightGray
        return obj
    }()
    
    var buttonsStackView: UIStackView = {
        let obj = UIStackView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.distribution = .fillEqually
        obj.spacing = 8
        return obj
    }()
    
//    var detectUsingOpenCvButton: UIButton = {
//        let obj = UIButton()
//        obj.translatesAutoresizingMaskIntoConstraints = false
//        obj.setTitle("Detect (Open CV)", for: .normal)
//        obj.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//        obj.setTitleColor(.white, for: .normal)
//        obj.backgroundColor = .darkGray
//        obj.layer.cornerRadius = 12
//        return obj
//    }()
    
    var detectUsingOpenCvButton: TopImageLabelView = {
//        let obj = LeadingImageLabelView(imageName: "microscope",
//                                        labelText: "Open CV",
//                                        labelcolor: .white,
//                                        labelLines: 1,
//                                        font: .boldSystemFont(ofSize: 24),
//                                        spacing: 12)
        
        let obj = TopImageLabelView(image: UIImage(named: "microscope"),
                                    labelText: "Open CV",
                                    labelcolor: .white)
        
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.topImageView.tintColor = .white
        obj.backgroundColor = .themeBlue
        obj.layer.cornerRadius = 12
        return obj
    }()
    
//    var detectUsingTensorFlowButton: UIButton = {
//        let obj = UIButton()
//        obj.translatesAutoresizingMaskIntoConstraints = false
//        obj.setTitle("Detect (Tensor Flow)", for: .normal)
//        obj.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//        obj.setTitleColor(.white, for: .normal)
//        obj.backgroundColor = .darkGray
//        obj.layer.cornerRadius = 12
//        return obj
//    }()
    
    var detectUsingTensorFlowButton: TopImageLabelView = {
//        let obj = LeadingImageLabelView(imageName: "faceDetection",
//                                        labelText: "Tensor Flow",
//                                        labelcolor: .white,
//                                        labelLines: 1,
//                                        font: .boldSystemFont(ofSize: 24),
//                                        spacing: 12)
        
        let obj = TopImageLabelView(image: UIImage(named: "faceDetection"),
                                    labelText: "Tensor Flow",
                                    labelcolor: .white)
        
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.topImageView.tintColor = .white
        obj.backgroundColor = .themeBlue
        obj.layer.cornerRadius = 12
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        promtForVideoCapturingPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        serverUrlLabel.text = DetectorUserDefaults.serverUrl
        mainAnimationView.play()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        let openCvGesture = UITapGestureRecognizer(target: self, action: #selector(startStreamingVideo(sender:)))
        detectUsingOpenCvButton.addGestureRecognizer(openCvGesture)
//        detectUsingOpenCvButton.addTarget(self, action: #selector(startStreamingVideo(sender:)), for: .touchUpInside)
        let tensorFlowGesture = UITapGestureRecognizer(target: self, action: #selector(startStreamingVideo(sender:)))
        detectUsingTensorFlowButton.addGestureRecognizer(tensorFlowGesture)
//        detectUsingTensorFlowButton.addTarget(self, action: #selector(startStreamingVideo(sender:)), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapUrlBtn))
        changeUrlButton.addGestureRecognizer(gesture)
        
        view.addSubview(changeUrlButtonContainer)
        view.addSubview(changeUrlButton)
        view.addSubview(serverUrlLabel)
        view.addSubview(mainAnimationView)
        view.addSubview(detectUsingLabel)
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(detectUsingOpenCvButton)
        buttonsStackView.addArrangedSubview(detectUsingTensorFlowButton)
        
        NSLayoutConstraint.activate([
            changeUrlButtonContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            changeUrlButtonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            changeUrlButton.topAnchor.constraint(equalTo: changeUrlButtonContainer.topAnchor, constant: 12),
            changeUrlButton.bottomAnchor.constraint(equalTo: changeUrlButtonContainer.bottomAnchor, constant: -12),
            changeUrlButton.leadingAnchor.constraint(equalTo: changeUrlButtonContainer.leadingAnchor, constant: 12),
            changeUrlButton.trailingAnchor.constraint(equalTo: changeUrlButtonContainer.trailingAnchor, constant: -12),
            changeUrlButton.heightAnchor.constraint(equalToConstant: 40),
            changeUrlButton.widthAnchor.constraint(equalToConstant: 40),

            serverUrlLabel.topAnchor.constraint(equalTo: changeUrlButtonContainer.bottomAnchor, constant: 20),
            serverUrlLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            serverUrlLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            mainAnimationView.topAnchor.constraint(equalTo: serverUrlLabel.bottomAnchor, constant: 12),
            mainAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainAnimationView.heightAnchor.constraint(equalToConstant: 240),
            
            detectUsingLabel.topAnchor.constraint(equalTo: mainAnimationView.bottomAnchor, constant: 16),
            detectUsingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            detectUsingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            buttonsStackView.topAnchor.constraint(equalTo: detectUsingLabel.bottomAnchor, constant: 12),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func promtForVideoCapturingPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("is authorized for video")
        case .denied, .restricted, .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                print("access given: \(granted)")
            }
        default:
            print("handle different authorization statusb")
        }
    }
    
    //MARK: - Section Name
    @objc func startStreamingVideo(sender: UIButton) {
        
        guard let urlString = DetectorUserDefaults.serverUrl,
              let url = URL(string: urlString) else {
            return
        }
        
        if sender == detectUsingOpenCvButton {
            let vc = VideoCapturingViewController(library: .openCV, serverUrl: url)
            self.present(vc, animated: true)
        } else if sender == detectUsingTensorFlowButton {
            let vc = VideoCapturingViewController(library: .tensorFlow, serverUrl: url)
            self.present(vc, animated: true)
        }
    }
    
    @objc func didTapUrlBtn() {
        let vc = ServerUrlViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
