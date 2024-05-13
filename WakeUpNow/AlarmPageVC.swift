//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class AlarmPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 네비게이션 바의 왼쪽에 '편집' 버튼 추가
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(editButtonTapped))
        
        // 네비게이션 바의 오른쪽에 '+' 버튼 추가
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
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
