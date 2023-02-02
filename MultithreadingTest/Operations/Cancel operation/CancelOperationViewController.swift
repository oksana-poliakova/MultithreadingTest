//
//  CancelOperationViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 02.02.2023.
//

import UIKit

final class CancelOperationViewController: UIViewController {

    // MARK: - Properties
    
    private let cancelOperation = OperationCancelTest()
    private let operationQueue = OperationQueue()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        cancelOperationMethod()
//        waitOperationTest()
//        waitOperationTest2()
        useOperationsWithCompletionBlock()
    }
    
    // MARK: - Using cancel method
    
    private func cancelOperationMethod() {
        // Method 1
        // Only the first operation will work, and the rest will be canceled
        operationQueue.addOperation(cancelOperation)
        cancelOperation.cancel()
        
        // Method 2
        // All operations will be canceled
        // waitUntilFinished - blocks the thread until all operations have completed
        operationQueue.addOperations([cancelOperation], waitUntilFinished: false)
        operationQueue.cancelAllOperations()
    }
    
    // MARK: - Task: firstly, operations #1 and #2 must be completed, and only after them all the rest operations
    
    private func waitOperationTest() {
        // Create operations inside the queue
        operationQueue.addOperation {
            sleep(1)
            print("Test 1")
        }
        operationQueue.addOperation {
            sleep(2)
            print("Test 2")
        }
        
        // waiting for the operations #1 and #2 will be completed
        operationQueue.waitUntilAllOperationsAreFinished()
        print("Waiting")
                
        operationQueue.addOperation {
            print("Test 3")
        }
        operationQueue.addOperation {
            print("Test 4")
        }
    }
    
    // MARK: - Another method for using waitUntilFinished with few operations
    // Block operation - firstly create operations using BlockOperation and after that add the array with operations to queue
    
    private func waitOperationTest2() {
        let operation1 = BlockOperation {
            sleep(1)
            print("Test 1")
        }
        let operation2 = BlockOperation {
            sleep(2)
            print("Test 2")
        }
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
        print("1 and 2 operations are completed")
        
        let operation3 = BlockOperation {
            print("Test 3")
        }
        
        operationQueue.addOperation(operation3)
    }
    
    // MARK: - Using completion block
    // For example, first we get some data and after that completion block is running and we doing something
    
    private func useOperationsWithCompletionBlock() {
        let operation1 = BlockOperation {
        // 2
            print("Test completion block")
        }
        // 3
        operation1.completionBlock = {
            print("Completion block has finished")
        }
        // 1
        operationQueue.addOperation(operation1)
    }
}

