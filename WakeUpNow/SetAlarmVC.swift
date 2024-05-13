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
        
        setupNextButton()
    }
    
    func setupNextButton() {
        // 버튼 생성
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("반복요일", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        // 버튼을 view에 추가
        view.addSubview(nextButton)
        
        // 버튼의 위치와 크기 설정
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func nextButtonTapped() {
        // 다음 화면으로 넘어가는 로직 구현
        let nextVC = SetDayVC() // 다음 화면의 뷰 컨트롤러 인스턴스 생성
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // '취소' 버튼이 탭되었을 때 호출될 메서드
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // '저장' 버튼이 탭되었을 때 호출될 메서드
    @objc func saveButtonTapped() {
        // 여기에 알람 저장 로직 구현
        print("알람이 저장되었습니다.")
    }
}
