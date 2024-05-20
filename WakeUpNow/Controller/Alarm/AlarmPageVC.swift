//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class AlarmPageVC: UIViewController, AlarmTableViewCellDelegate {

    var alarms: [Alarm] = []
    var tableView: UITableView!

    func didTapCell(_ cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = alarms[indexPath.row]

        let setAlarmVC = SetAlarmVC()
        setAlarmVC.alarm = alarm
        setAlarmVC.onSave = { [weak self] updatedAlarm in
            self?.alarms[indexPath.row] = updatedAlarm
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        present(setAlarmVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

        setupTableView()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func editButtonTapped() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        self.navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "완료" : "편집"
    }

    @objc func addButtonTapped() {
        let setAlarmVC = SetAlarmVC()
        setAlarmVC.onSave = { [weak self] newAlarm in
            self?.alarms.append(newAlarm)
            self?.tableView.reloadData()
        }
        let navigationController = UINavigationController(rootViewController: setAlarmVC)
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension AlarmPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier, for: indexPath) as! AlarmTableViewCell
        let alarm = alarms[indexPath.row]
        cell.configure(with: alarm)
        cell.delegate = self
        return cell
    }
}

extension AlarmPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
