
//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class AlarmPageVC: UIViewController {
    
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
        tableView.register(AlarmTableViewCell.self, forCellReuseIdentifier: "AlarmTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        // SnapKit을 사용
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
        
        // SetAlarmVC를 UINavigationController의 루트 뷰 컨트롤러로 설정
        let navigationController = UINavigationController(rootViewController: setAlarmVC)
        
        // 네비게이션 컨트롤러를 모달 형태로 표시
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension AlarmPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 // 기존에는 5였지만, 특별한 첫 번째 셀을 위해 1을 더함
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        // 첫 번째 셀에는 '알람'만 표시
        if indexPath.row == 0 {
            cell.textLabel?.text = "알람"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
            
            // 알람 데이터를 생성합니다. 실제 앱에서는 이 부분을 데이터 소스로부터 가져온 데이터로 교체해야 합니다.
            let dummyViewModel = AlarmViewModel(meridiem: indexPath.row % 2 == 0 ? "오전" : "오후", time: "\(indexPath.row + 7):00", isActive: indexPath.row % 2 == 0)
            
            // 셀을 구성합니다.
            cell.configure(with: dummyViewModel)
            
            return cell
        }
    }
}


extension AlarmPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 // 원하는 셀의 높이를 지정
    }
}