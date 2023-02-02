//
//  DispatchWorkItemViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 31.01.2023.
//

import UIKit

final class DispatchWorkItemViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var testImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createDispatchWorkItem1()
//        createDispatchWorkItem2()
        fetchImage()
    }
    
    // MARK: - DispatchWorkItem example 1
    
    /* A DispatchWorkItem encapsulates work to be performed on a dispatch queue or within a dispatch group. You can also use a work item as a DispatchSource event, registration, or cancellation handler. */
    
    private func createDispatchWorkItem1() {
        let queue = DispatchQueue(label: "createDispatchWorkItem1", attributes: .concurrent)
        
        func create() {
            let workItem = DispatchWorkItem {
                print(Thread.current)
                print("Start task1")
            }
            
            workItem.notify(queue: .main) {
                print(Thread.current)
                print("Finish tasss")
            }
            
            queue.async(execute: workItem)
        }
        
        create()
    }
    
    // MARK: - DispatchWorkItem example 2
    
    private func createDispatchWorkItem2() {
        // DispatchQueue without attributes it's a serial queue
        let queue = DispatchQueue(label: "DispatchWorkItem2")
        
        func create() {
            queue.async {
                sleep(2)
                print("Task 1")
            }
            
            queue.async {
                sleep(2)
                print("Task 2")
            }
            
            queue.async {
                sleep(2)
                print("Task 3")
            }
            
            let workItem = DispatchWorkItem {
                print(Thread.current)
                print("DispatchWorkItem started working")
            }
            
            // firstly starts here
            queue.async(execute: workItem)
            
            // cancels only the task that has not yet started executing
            // in this case last prints inside DispatchWorkItem won't appear
            workItem.cancel()
        }
        
        create()
    }
    
    // MARK: - DispatchWorkItem example 3
    
    private func fetchImage() {
        var data: Data?
        guard let firstURLImageString = URL(string:                 "https://digwallpapers.com/wallpapers/full/5/9/c/10748-3840x2160-switzerland-background-photo-desktop-4k.jpg") else { return }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: firstURLImageString)
            print(Thread.current)
        }
        
        queue.async(execute: workItem)
        
        // workItem.notify is waiting when workItem ends his functions and after that starts notifyн
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                self.testImage.image = UIImage(data: imageData)
            }
        }
    }
}



