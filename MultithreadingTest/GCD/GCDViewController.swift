//
//  ViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 24.01.2023.
//

import UIKit

final class GCDViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var pressButton: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        title = "First ViewController"
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AdditionalGCDViewController", bundle: nil).instantiateViewController(withIdentifier: "AdditionalGCDViewController") as? AdditionalGCDViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
        print("pressed")
    }
    
}

