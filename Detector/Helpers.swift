//
//  Helpers.swift
//  Detector
//
//  Created by Macbook on 26/07/2022.
//

import Foundation
import UIKit

enum FrameProcessingLibrary {
    case tensorFlow, openCV
}

struct DetectorUserDefaults {
    static var serverUrl: String? {
        get {
            return UserDefaults.standard.string(forKey: "serverUrl")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "serverUrl")
        }
    }
}

extension UIImage {
    var toBase64: String? {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var image: UIImage? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return UIImage(data: data)
    }
}

