//
//  WakeUpVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/21/24.
//

import UIKit

class WakeUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "일어나세요!"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
}
