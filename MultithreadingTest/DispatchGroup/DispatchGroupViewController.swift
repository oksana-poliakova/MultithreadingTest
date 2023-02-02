//
//  DispatchGroupViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 01.02.2023.
//

import UIKit

final class DispatchGroupViewController: UIViewController {
    
    // MARK: - Properties
    
    private let serialQueue = DispatchQueue(label: "Serial Queue")
    private let concurrentQueue = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)
    private let queuesGroup = DispatchGroup()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        testDispatchGroup()
//        testDispatchGroupConcurrent()
        
    }
    
    // MARK: - Dispatch Group serial
    
    private func testDispatchGroup() {
        serialQueue.async(group: queuesGroup) {
            sleep(2)
            print("1")
        }
        
        serialQueue.async(group: queuesGroup) {
            sleep(1)
            print("2")
        }
        
        queuesGroup.notify(queue: .main) {
            print("Group has finished")
        }
    }
    
    // MARK: - Dispatch Group concurrent
    
    private func testDispatchGroupConcurrent() {
        queuesGroup.enter() // -1 thread
        concurrentQueue.async {
            print("1")
            self.queuesGroup.leave() // +1 thread
            print("1 - It has leaved")
        }
        
        queuesGroup.enter()
        concurrentQueue.async {
            print("2")
            self.queuesGroup.leave()
            print("2 - It has leaved")
        }
        
        // wait() means that we wait until the above section of code is executed
        queuesGroup.wait()
        print("All has finished")
        
        queuesGroup.notify(queue: .main) {
            print("Group has finished")
        }
    }
}
