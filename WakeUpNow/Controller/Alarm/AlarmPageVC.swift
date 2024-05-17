//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class AlarmPageVC: UIViewController {
    
    var alarms: [Alarm] = []
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        // 네비게이션 바의 왼쪽에 '편집' 버튼 추가
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        
        // 네비게이션 바의 오른쪽에 '+' 버튼 추가
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        // 테이블뷰 설정 및 레이아웃
        setupTableView()
    }
    
    func setupTableView() {
        // 테이블뷰 초기화 및 설정
        tableView = UITableView()
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: AlarmTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        // SnapKit을 사용하여 레이아웃 설정
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // '편집' 버튼이 탭되었을 때 호출될 메서드
    @objc func editButtonTapped() {
        // 편집 관련 동작 구현
        print("편집 버튼이 탭되었습니다.")
    }
    
    // '+' 버튼이 탭되었을 때 호출될 메서드
    @objc func addButtonTapped() {
        let setAlarmVC = SetAlarmVC()
        
        // 알람을 설정하고 완료했을 때 호출될 클로저를 정의합니다.
        setAlarmVC.onSave = { [weak self] newAlarm in
            self?.alarms.append(newAlarm)
            self?.tableView.reloadData()
        }
        
        // SetAlarmVC를 UINavigationController의 루트 뷰 컨트롤러로 설정
        let navigationController = UINavigationController(rootViewController: setAlarmVC)
        
        // 네비게이션 컨트롤러를 모달 형태로 표시
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
        
        return cell
    }
}

extension AlarmPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // 원하는 셀의 높이를 지정
    }
}
