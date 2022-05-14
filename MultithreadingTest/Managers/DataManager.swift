//
//  DataManager.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 14.05.2022.
//

import UIKit

class DataManager {
    
    // MARK: - GCD
    
    class func obtainData(completion: @escaping (([String]) ->  Void)) {
        
        var dataSource = [String]()
        let group = DispatchGroup()
        
        /// in each block must be enter() and leave()
        group.enter()
        
        DispatchQueue.global().async {
            dataSource.append("Hello")
            
            group.leave()
        }
        
        group.enter()
        
        DispatchQueue.global(qos: .utility).async {
            dataSource.append("I'm here")
            
            group.leave()
        }
        
        group.enter()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            dataSource.append("!!!")
            dataSource.append("Where are you?")
            
            group.leave()
        }
        
        /// notify works only when number of enters = number of leaves 
        group.notify(queue: .main) {
            completion(dataSource)
        }
    }
    
    // MARK: - OperationQueue
    
//    class func obtainDataOperation (completion: @escaping (([String]) -> Void)) {
//
//        var data = [String]()
//        let operationQueue = OperationQueue()
//        operationQueue.maxConcurrentOperationCount = 1
//        operationQueue.qualityOfService = .userInteractive
//
//        DispatchQueue.global().async {
//            let operationFirstBlock = BlockOperation {
//                for i in 0..<5 {
//                    data.append("\(i)😌")
//                }
//            }
//
//            let operationSecondBlock = BlockOperation {
//                for i in 0..<5 {
//                    data.append("\(i)😇")
//                }
//            }
//
//            let operationThirdBlock = BlockOperation {
//                for i in 0..<5 {
//                    data.append("This is a third block operation")
//                }
//            }
//
//            // MARK: - Dependency between operations
//            // The third operation must be completed last
//
//            operationThirdBlock.addDependency(operationFirstBlock)
//            operationThirdBlock.addDependency(operationSecondBlock)
//
//            // MARK: - Adding operations
//
//            operationQueue.addOperations([operationFirstBlock, operationSecondBlock, operationThirdBlock], waitUntilFinished: true)
//
//            completion(data)
//
//        }
//    }
}
