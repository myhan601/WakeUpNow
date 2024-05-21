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

        let editButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        editButtonItem.tintColor = .black // 여기에서 버튼 색상을 검은색으로 설정합니다.
        self.navigationItem.leftBarButtonItem = editButtonItem
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
        // alarms 배열의 길이에 1을 더함
        return alarms.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 첫 번째 셀인 경우
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") ?? UITableViewCell(style: .default, reuseIdentifier: "BasicCell")
            cell.textLabel?.text = "알람"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 35, weight: .medium)
            cell.textLabel?.textAlignment = .left
            return cell
        } else {
            // indexPath.row에 1을 빼서 실제 alarms 배열의 인덱스에 맞춤
            let alarmIndex = indexPath.row - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: AlarmTableViewCell.identifier, for: indexPath) as! AlarmTableViewCell
            let alarm = alarms[alarmIndex]
            cell.configure(with: alarm)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // 첫 번째 셀의 경우 편집 불가능
        return indexPath.row != 0
    }
}

extension AlarmPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // 첫 번째 셀의 높이 설정
            return 70
        } else {
            // 나머지 셀의 높이 설정
            return 80
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.row != 0 { // 첫 번째 셀은 삭제 불가능하게
            let alarmIndex = indexPath.row - 1
            alarms.remove(at: alarmIndex)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // 첫 번째 셀을 선택할 수 없게 만드는 옵션
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.row == 0 ? nil : indexPath
    }
}
