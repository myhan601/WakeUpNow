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
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.frame = self.view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = soundOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSound = soundOptions[indexPath.row]
        delegate?.setAlarmSound(named: selectedSound)
        dismiss(animated: true, completion: nil)
    }
}
