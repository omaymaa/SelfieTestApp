//
//  ViewController.swift
//  SelfieTestApp
//
//  Created by Omayma Marouf on 11/10/2024.
//

import UIKit
import ValifySelfieFramework  // Import the framework

class ViewController: UIViewController {
    
    @IBOutlet weak var selfieBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    private var capturedImage: UIImage? // Store the captured image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI() // Set up the initial UI state
    }
    
    // Function to set up the initial UI elements
        private func setupInitialUI() {
            titleLbl.isHidden = true // Hide the title label initially
            selfieBtn.setTitle("Capture Selfie", for: .normal) // Set the initial title for the selfie button
        }
    
    
    @IBAction func launchCamera(_ sender: Any) {
        let cameraVC = CameraViewController() // Assuming this is part of the framework to capture a selfie
         cameraVC.delegate = self // Setting the delegate to handle the captured image
        present(cameraVC, animated: true)
    }
    
}

// MARK: - ValifySelfieFrameworkDelegate
// Extension to handle delegate methods for capturing selfies
extension ViewController: ValifySelfieFrameworkDelegate {
    // Method called when an image is captured
    func didCaptureImage(_ image: UIImage) {
        // Dismiss the camera view controller before showing the image preview
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            
            // Instantiate the image preview view controller for approval
            let previewVC = ImagePreviewViewController(image: image)
            previewVC.delegate = self // Set the delegate to handle approval or recapture
            self.present(previewVC, animated: true) // Present the image preview controller
        }
    }
}

// MARK: - ImagePreviewDelegate
// Extension to handle delegate methods for image preview
extension ViewController: ImagePreviewDelegate {
    // Method called when the user approves the captured image
    func didApproveImage(_ image: UIImage) {
        // Show the title label and update its text to indicate success
        titleLbl.isHidden = false
        titleLbl.text = "Sent Successfully" // Update the label text
        
        // Change the button title to indicate the user can take another selfie
        selfieBtn.setTitle("Take a Selfie", for: .normal)
        
        // Notify the user that the selfie has been approved using an alert
        let alert = UIAlertController(title: "Selfie Approved", message: "Your selfie has been approved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default)) // Add an "OK" action to the alert
        present(alert, animated: true) // Present the alert
    }
    
    // Method called when the user requests to recapture the selfie
    func didRequestRecapture() {
        // Relaunch the camera to recapture the selfie
        launchCamera(self)
    }
}
