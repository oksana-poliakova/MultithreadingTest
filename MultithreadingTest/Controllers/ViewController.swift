//
//  ViewController.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 14.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
     
    private var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Using GCD
        
        DataManager.obtainData { [weak self] (stringsArray) in
            self?.dataSource = stringsArray

            /// after getting the data => reload data in UI
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        // MARK: - Using OperationQueue
        
//        DataManager.obtainDataOperation { [weak self] (stringsArray) in
//            self?.dataSource = stringsArray
//            
//            /// after getting the data => reload data in UI
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
//        }
    }
}

extension ViewController: UITableViewDelegate {
        
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestTableViewCell") as? TestTableViewCell else  { return UITableViewCell() }
        cell.configureCell(text: dataSource[indexPath.row])
        return cell
    }
    
    
}
