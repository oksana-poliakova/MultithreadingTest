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
    @IBOutlet private weak var goToDispatchWorkItemsButton: UIButton!
    @IBOutlet private weak var semaphoreButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        useConcurrentPerform()
        
        getDataWithDelay(seconds: 5, queue: .main) {
//            print("Test code with delay")
            self.showAlert()
//            print(Thread.current)
        }
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        title = "First ViewController"
    }
    
    // MARK: - Async after
    
    private func getDataWithDelay(seconds: Int,
                                  queue: DispatchQueue = DispatchQueue.global(),
                                  completion: @escaping () -> ()) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Hello", message: "It's alert", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Concurrent perform
    /* Submits a single block to the dispatch queue and causes the block to be executed the specified number of times. */
    
    private func useConcurrentPerform() {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            DispatchQueue.concurrentPerform(iterations: 200) {_ in
//                print("\($0) times")
//                print(Thread.current)
            }
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "AdditionalGCDViewController", bundle: nil).instantiateViewController(withIdentifier: "AdditionalGCDViewController") as? AdditionalGCDViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToDispatchWorkItemsButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "DispatchWorkItemViewController", bundle: nil).instantiateViewController(withIdentifier: "DispatchWorkItemViewController") as? DispatchWorkItemViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func semaphoreButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "SemaphoreViewController", bundle: nil).instantiateViewController(withIdentifier: "SemaphoreViewController") as? SemaphoreViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

