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
        
        view.backgroundColor = .white
        
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        // SnapKit을 사용하여 테이블뷰의 제약조건 설정
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
        // 추가 관련 동작 구현
        print("'+' 버튼이 탭되었습니다.")
    }
}

extension AlarmPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션당 행의 수를 5로 설정
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀을 재사용하거나 새로 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        // 셀 내용 설정
        cell.textLabel?.text = "알람 \(indexPath.row + 1)"
        return cell
    }
}

extension AlarmPageVC: UITableViewDelegate {
    
}
