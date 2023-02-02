//
//  OperationQueueViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 02.02.2023.
//

import UIKit

final class OperationQueueViewController: UIViewController {
    
    // MARK: - Properties
    
    private let queue = OperationQueue()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testThreads()
       // testBlock()
    }
    
    // MARK: - Test threads
    
    private func testThreads() {
        print(Thread.current)
        
        let testThreads = {
            print("Start")
            print(Thread.current)
            print("Finish")
        }
        
        queue.addOperation(testThreads)
    }
    
    private func testBlock() {
        var result: String?
        
        let concatStringOperation = BlockOperation {
            print(Thread.current)
            result = "First string" + " " + "Second String"
        }
        
        let queue = OperationQueue()
        // add an operation and start
        queue.addOperation {
            print(Thread.current)
            concatStringOperation.start()
        }
        print(Thread.current)
        print(result as? String)
    }
}
