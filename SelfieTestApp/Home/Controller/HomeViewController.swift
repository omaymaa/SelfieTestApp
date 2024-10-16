//
//  HomeViewController.swift
//  SelfieTestApp
//
//  Created by Omayma Marouf on 11/10/2024.
//

import UIKit
import ValifySelfieFramework  // Import the framework

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func launchCamera(_ sender: Any) {
        let cameraVC = CameraViewController() // Assuming this is part of the framework to capture a selfie
         cameraVC.delegate = self // Setting the delegate to handle the captured image
        present(cameraVC, animated: true)
    }
    
}

// MARK: - ValifySelfieFrameworkDelegate
// Extension to handle delegate methods for capturing selfies
extension HomeViewController: ValifySelfieFrameworkDelegate {
    // Method called when an image is captured
    func didCaptureImage(_ image: UIImage) {
        // Dismiss the camera view controller before showing the image preview
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            // Instantiate the image preview view controller for approval
            let previewVC = ImagePreviewViewController(image: image)
            previewVC.delegate = self // Set the delegate to handle approval or recapture
            self.present(previewVC, animated: true)
        }
    }
}

// MARK: - ImagePreviewDelegate
// Extension to handle delegate methods for image preview
extension HomeViewController: ImagePreviewDelegate {
    // Method called when the user approves the captured image
    func didApproveImage(_ image: UIImage) {
        // Dismiss any currently presented view controller before showing a new alert
        if let presentedVC = self.presentedViewController {
            presentedVC.dismiss(animated: false) { [weak self] in
                self?.showApprovalAlert()
            }
        } else {
            showApprovalAlert()
        }
    }

    private func showApprovalAlert() {
        // Create and present the alert confirming approval
        let alert = UIAlertController(title: "Selfie Approved", message: "Your selfie has been approved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
        }))
        present(alert, animated: true)
    }

    
    // Method called when the user requests to recapture the selfie
    func didRequestRecapture() {
        // Relaunch the camera to recapture the selfie
        launchCamera(self)
    }
}
