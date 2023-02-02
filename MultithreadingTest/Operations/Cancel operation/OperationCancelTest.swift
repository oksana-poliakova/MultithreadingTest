//
//  OperationCancelTest.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 02.02.2023.
//

import Foundation

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 1")
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 2")
    }
}
