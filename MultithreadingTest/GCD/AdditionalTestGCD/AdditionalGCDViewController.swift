//
//  AdditionalGCDViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 30.01.2023.
//

import UIKit
import Kingfisher

final class AdditionalGCDViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        title = "Second ViewController"
        getImages()
    }
    
    // MARK: - Get images
    
    private func getImages() {
        guard
            let firstURLImageString = URL(string: "https://digwallpapers.com/wallpapers/full/5/9/c/10748-3840x2160-switzerland-background-photo-desktop-4k.jpg"),
            let secondURLImageString = URL(string: "https://i0.wp.com/indiacurrents.com/wp-content/uploads/2017/03/travel-featured-size.jpg?fit=760%2C360&ssl=1"),
            let thirdURLImageString = URL(string: "https://i0.wp.com/thelostboyds.com/wp-content/uploads/2016/08/FullSizeRender-1.jpg?resize=640%2C480")
        else {
            return
        }
        
        // MARK: - Using Kingfisher
        
        self.firstImageView.kf.setImage(with: firstURLImageString)
        self.secondImageView.kf.setImage(with: secondURLImageString)
        self.thirdImageView.kf.setImage(with: thirdURLImageString)
        
        // MARK: - We can't receive data in the main thread, visually the view controller will be loaded for a long time and we will get an error that data cannot be loaded in the main thread
        
        //        if let data = try? Data(contentsOf: firstURLImageString) {
        //            self.firstImageView.image = UIImage(data: data)
        //        }
        //
        //        if let data = try? Data(contentsOf: secondURLImageString) {
        //            self.secondImageView.image = UIImage(data: data)
        //        }
        //
        //        if let data = try? Data(contentsOf: thirdURLImageString) {
        //            self.thirdImageView.image = UIImage(data: data)
        //        }
        
        // MARK: - We can't leave the UI on the global thread, visually the UI elements won't be rendered on the screen. UI is passed only to the main thread. Must be only async in this case.
        
        //        let queue = DispatchQueue.global(qos: .utility)
        //        queue.async {
        //            if let data = try? Data(contentsOf: firstURLImageString) {
        //                self.firstImageView.image = UIImage(data: data)
        //            }
        //
        //            if let data = try? Data(contentsOf: secondURLImageString) {
        //                self.secondImageView.image = UIImage(data: data)
        //            }
        //
        //            if let data = try? Data(contentsOf: thirdURLImageString) {
        //                self.thirdImageView.image = UIImage(data: data)
        //            }
        //        }
        
        // MARK: - NEVER call the sync function on the main queue.
        /* If we call the sync function on the main queue it will block. the queue as well as the queue will be waiting for the task to be completed but the task will never be finished since it will not be even able to start due to the queue is already blocked. It is called deadlock. Enters DispatchQueue.main.sync and ends there. The main queue is blocked. The app is crashing.
         For instance, main.sync waits for the function getImages() to complete, and the function getImages() waits for the sync to run - deadlock */
        
        //        DispatchQueue.main.sync {
        //            if let data = try? Data(contentsOf: firstURLImageString) {
        //                self.firstImageView.image = UIImage(data: data)
        //            }
        //
        //            if let data = try? Data(contentsOf: secondURLImageString) {
        //                self.secondImageView.image = UIImage(data: data)
        //            }
        //
        //            if let data = try? Data(contentsOf: thirdURLImageString) {
        //                self.thirdImageView.image = UIImage(data: data)
        //            }
        //        }
        
        // MARK: - The data is getting in the global thread, the UI is displayed in the main thread.
        
        //        let queue = DispatchQueue.global(qos: .utility)
        //        queue.async {
        //            if let data = try? Data(contentsOf: firstURLImageString) {
        //                DispatchQueue.main.sync {
        //                     self.firstImageView.image = UIImage(data: data)
        //                }
        //            }
        //
        //            if let data = try? Data(contentsOf: secondURLImageString) {
        //                DispatchQueue.main.sync {
        //                    self.secondImageView.image = UIImage(data: data)
        //                }
        //            }
        //
        //            if let data = try? Data(contentsOf: thirdURLImageString) {
        //                DispatchQueue.main.sync {
        //                    self.thirdImageView.image = UIImage(data: data)
        //                }
        //            }
        //        }
        //    }
    }
}
