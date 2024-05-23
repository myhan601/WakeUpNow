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

class SoundSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: SoundSettingDelegate?
    
    let soundOptions = ["Alarm", "Apex", "Ascending", "Bark", "Beacon", "Bell Tower", "Blues", "Boing", "Bullentin", "By The Seaside", "Chimes", "Circuit"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorPalette.wakeLightBeige
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundOptions[indexPath.row]
        cell.backgroundColor = ColorPalette.wakeBeige
        cell.textLabel?.textColor = ColorPalette.wakeDarkGray
        
        if indexPath.row == 0 {
            cell.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        } else if indexPath.row == soundOptions.count - 1 {
            cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        } else {
            cell.roundCorners(corners: [], radius: 0.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSound = soundOptions[indexPath.row]
        delegate?.setAlarmSound(named: selectedSound)
        dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
