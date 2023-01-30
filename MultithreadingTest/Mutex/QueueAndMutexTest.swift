//
//  QueueAndMutexTest.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 30.01.2023.
//

import UIKit

class QueueAndMutexTest {
    
    // MARK: - Queue creating
    
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let concurrentQueue = DispatchQueue(label: "concurrentTest", attributes: .concurrent)
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
}

class TestViewController: UIViewController {
    
    struct SomeMutex {
        let someMutex = NSLock()
        
        func someMethod(completion: () -> ()) {
            defer {
                someMutex.unlock()
            }
            
            someMutex.lock()
            completion()
        }
    }
    
    var someArray = [String]()
    let mutex = SomeMutex()

    override func viewDidLoad() {
        super.viewDidLoad()
        callThread()
        usingMutex()
    }

    // MARK: - Thread calling
    
    private func callThread() {
        let nsThread = Thread {
            print("it's a thread")
        }
        
        nsThread.qualityOfService = .userInteractive
        nsThread.start()
        print(qos_class_main())
    }
    
    // MARK: - Mutex
    
    private func usingMutex() {
        mutex.someMethod {
            print("test")
            someArray.append("1 Thread")
            someArray.append("2 Thread")
            print(someArray.count)
        }
    }
}





