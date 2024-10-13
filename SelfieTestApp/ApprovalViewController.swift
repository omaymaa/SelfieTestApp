//
//  ApprovalViewController.swift
//  SelfieTestApp
//
//  Created by Omayma Marouf on 13/10/2024.
//

import UIKit

class ApprovalViewController: UIViewController {
    
    private let approvedLabel: UILabel = {
        let label = UILabel()
        label.text = "Selfie Approved Successfully"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let returnHomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Return to Home", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(returnHomeTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI
        view.backgroundColor = .white
        
        // Add the label and button to the view
        view.addSubview(approvedLabel)
        view.addSubview(returnHomeButton)
        
        // Set up constraints (Assuming you're using Auto Layout)
        approvedLabel.translatesAutoresizingMaskIntoConstraints = false
        returnHomeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            approvedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            approvedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            returnHomeButton.topAnchor.constraint(equalTo: approvedLabel.bottomAnchor, constant: 20),
            returnHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func returnHomeTapped() {
        // Dismiss to return to the home screen
        dismiss(animated: true, completion: nil)
    }
}
