//
//  FrameExtractor.swift
//  Detector
//
//  Created by Macbook on 26/07/2022.
//

import Foundation
import AVKit
import MobileCoreServices

class FrameExtractor: NSObject {
    
    //MARK: - Section Name
    let captureSession = AVCaptureSession()
    let imageHandler: (UIImage) -> Void
    
    //MARK: - Section Name
    init(imageHandler: @escaping (UIImage) -> Void) {
        self.imageHandler = imageHandler
        super.init()
    }
    
    //MARK: - Section Name
    public func startSession() {
        captureSession.sessionPreset = .medium
        
        //input
        guard let device = getCapturingDevice() else {
            print("No capturing device found")
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            print("Unable to get capture device input")
            return
        }
        guard captureSession.canAddInput(input) else {
            print("cannot add input")
            return
        }
        captureSession.addInput(input)
        
        //output
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: .main)
        
        guard captureSession.canAddOutput(videoOutput) else {
            print("cannot add output")
            return
        }
        
        captureSession.addOutput(videoOutput)
        print("did added output")
        
        captureSession.startRunning()
    }
    
    private func getCapturingDevice() -> AVCaptureDevice? {
        let devicesDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
        return devicesDiscoverySession.devices.first
    }
}

extension FrameExtractor: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let ciImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) //sampleBuffer.imageBuffer
        else {
            print("no image buffer")
            return
        }
        
        let ciImage = CIImage(cvPixelBuffer: ciImageBuffer)
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent)  //ciImage.cgImage
        else {
            print("no cg image found")
            return
        }
        
        let uiImage = UIImage(cgImage: cgImage)
        
//        print("Sending the image")
        imageHandler(uiImage)
    }
}
