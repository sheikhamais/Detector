//
//  VideoCapturingViewController.swift
//  Detector
//
//  Created by Macbook on 26/07/2022.
//

import Foundation
import UIKit

class VideoCapturingViewController: UIViewController {
    
    //MARK: - Section Name
    private var frameProcessingMethodology: FrameProcessingLibrary
    lazy var frameExtractor = FrameExtractor(imageHandler: handleImageFrame(image:))
    var serverUrl: URL
    
    let session = URLSession(configuration: .default)
    
    var frameImageView: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = .darkGray
        obj.contentMode = .scaleAspectFit
        return obj
    }()
    
    //MARK: - Section Name
    init(library: FrameProcessingLibrary, serverUrl: URL) {
        self.frameProcessingMethodology = library
        self.serverUrl = serverUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Section Name
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        frameExtractor.startSession()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(frameImageView)
        NSLayoutConstraint.activate([
            frameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            frameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            frameImageView.topAnchor.constraint(equalTo: view.topAnchor),
            frameImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func handleImageFrame(image: UIImage) {
        
        guard let imageBase64String = image.toBase64 else {
            return
        }
        
        
//        let parameters: [String : Any] = [
//            "image": imageBase64String
//        ]
        
        let body = ImageParameters(image: imageBase64String)
        let jsonBodyData = try? JSONEncoder().encode(body)
//        print(String(data: jsonBodyData ?? Data(), encoding: .utf8))
        
//        NetworkClient.shared.postApiRequest(url: serverUrl, body: parameters) { data, response, error in
//            print("did received data \(data)")
//            guard let data = data else {
//                return
//            }
////            let imageString = String(data: data, encoding: .utf8) else {
////                return
////            }
////            let decodedImage = imageString.image
//                    let decodedImage = UIImage(data: data)
//            self.frameImageView.image = decodedImage
//        }
        
        var urlRequest = URLRequest(url: serverUrl)
        urlRequest.httpMethod = HttpMethod.post.rawValue
        urlRequest.httpBody = jsonBodyData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        if let body = body
//        { urlRequest.httpBody = getDataForHttpbody(body: body) }
        
        let task = session.dataTask(with: urlRequest)
        { data, response, error in
            
//            completion(data, response, error)
//            print(data)
//            print(error?.localizedDescription)
            DispatchQueue.main.async {
//                print(data)
                guard let data = data else {
                    return
                }
                
//                let decodedImage = UIImage(data: data)
//                print("setting up image \(decodedImage)")
                let image = String(data: data, encoding: .utf8)
                let convertedData = Data(base64Encoded: data, options: .ignoreUnknownCharacters)
                print("Image data is: \(convertedData)")
                self.frameImageView.image = UIImage(data: convertedData ?? Data())
            }
        }
        
        task.resume()
        
    }
}

struct ImageParameters: Codable {
    var image: String
}
