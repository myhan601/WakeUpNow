//
//  SetDayVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit

class SetDayVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "반복"
        // 화면의 배경색 설정
        view.backgroundColor = .white
        
        // 사용자 정의 뒤로 가기 버튼 추가
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
    }
    
    @objc func goBack() {
        // 네비게이션 컨트롤러를 사용하여 이전 화면으로 이동
        self.navigationController?.popViewController(animated: true)
    }

}

