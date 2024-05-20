//
//  SoundSettingViewController.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/20/24.
//

import UIKit

protocol SoundSettingDelegate: AnyObject {
    func setAlarmSound(named soundName: String)
}

class SoundSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSound: String = "forest"
    var soundOptions = ["forest", "correct", "ttang"]
    weak var delegate: SoundSettingDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundOptions[indexPath.row]
        cell.backgroundColor = UIColor(red: 230/255, green: 224/255, blue: 212/255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 30/255, green: 38/255, blue: 41/255, alpha: 1)
        
        if indexPath.row == 0 {
            cell.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        } else if indexPath.row == soundOptions.count - 1 {
            cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        } else {
            cell.roundCorners(corners: [], radius: 0.0)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let soundName = soundOptions[indexPath.row]
        selectedSound = soundName
        delegate?.setAlarmSound(named: soundName)
        dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}
