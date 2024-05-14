//
//  SetDayVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit

class SetDayVC: UIViewController, UITableViewDataSource {

    // 테이블뷰 인스턴스 생성
    var tableView: UITableView!
    
    // 데이터 소스 배열
    let days = ["일요일마다", "월요일마다", "화요일마다", "수요일마다", "목요일마다", "금요일마다", "토요일마다"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "반복"
        view.backgroundColor = .systemBackground
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
        
        // 테이블뷰 설정
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.isScrollEnabled = false
        tableView.dataSource = self  // 데이터 소스 설정
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // 상단 여백 추가
        view.addSubview(tableView)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // UITableViewDataSource 프로토콜 필수 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = days[indexPath.row]
        cell.textLabel?.textAlignment = .left  // 텍스트 왼쪽 정렬
        return cell
    }
}

