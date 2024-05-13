//
//  SetAlarmVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit

class SetAlarmVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // 네비게이션 바 타이틀 설정
        self.title = "알람 추가"
        
        // 네비게이션 바 왼쪽에 '취소' 버튼 추가
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        // 네비게이션 바 오른쪽에 '저장' 버튼 추가
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    // '취소' 버튼이 탭되었을 때 호출될 메서드
    @objc func cancelButtonTapped() {
        // 현재 뷰 컨트롤러를 닫음
        self.dismiss(animated: true, completion: nil)
        // 또는 네비게이션 스택에서 이전 화면으로 돌아가기를 원한다면
        // self.navigationController?.popViewController(animated: true)
    }
    
    // '저장' 버튼이 탭되었을 때 호출될 메서드
    @objc func saveButtonTapped() {
        // 여기에 알람 저장 로직 구현
        print("알람이 저장되었습니다.")
    }
}
