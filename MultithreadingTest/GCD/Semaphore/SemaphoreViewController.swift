//
//  SemaphoreViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 31.01.2023.
//

import UIKit

final class SemaphoreViewController: UIViewController {
    
    // MARK: - Prorepties
    
    private let queue = DispatchQueue(label: "Semaphore", attributes: .concurrent)
    // It means this can be 1 queue with 3 threads
   
    // The semaphore controls the bandwidth of the queue, how many threads can be skipped at one time
    // when it will be a mutex, value will be only 1
    let semaphore = DispatchSemaphore(value: 2)

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        useSemaphore()
    }
    
    // MARK: - Private functions
    
    private func useSemaphore() {
        
        queue.sync {
            self.semaphore.wait() // -1
            print("Method 1")
            self.semaphore.signal() // +1
        }
        
        queue.sync {
            self.semaphore.wait()
            print("Method 2")
            self.semaphore.signal()

        }
        
        queue.sync {
            self.semaphore.wait()
            print("Method 3")
            self.semaphore.signal()
        }
        
        queue.sync {
            self.semaphore.wait()
            print("Method 4")
            self.semaphore.signal()
        }
    }
}

/*
    let semaphore = DispatchSemaphore(value: 0) + async - doesn't work
    let semaphore = DispatchSemaphore(value: 2) + async - all work, 2 threads at the same time, all 4 threads have worked, but have some warnings from Xcode
 
    let semaphore = DispatchSemaphore(value: 0) + sync - app is stuck
    let semaphore = DispatchSemaphore(value: 2) + sync - all work, all 4 threads
 */
