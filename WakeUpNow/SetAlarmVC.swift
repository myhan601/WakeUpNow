//
//  SetAlarmVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class SetAlarmVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.title = "알람 추가"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        setupNextButton()
        setupSoundSettingButton() // '소리 설정' 버튼 설정 함수 호출
    }
    
    func setupNextButton() {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("반복요일", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        // SnapKit을 사용한 제약 설정
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30) // '소리 설정' 버튼과 겹치지 않도록 조정
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setupSoundSettingButton() {
        let soundSettingButton = UIButton(type: .system)
        soundSettingButton.setTitle("소리 설정", for: .normal)
        soundSettingButton.addTarget(self, action: #selector(soundSettingButtonTapped), for: .touchUpInside)
        view.addSubview(soundSettingButton)
        
        // SnapKit을 사용한 제약 설정
        soundSettingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30) // '반복요일' 버튼에 대해 상대적으로 위치 조정
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    @objc func nextButtonTapped() {
        let nextVC = SetDayVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        print("알람이 저장되었습니다.")
    }
    
    @objc func soundSettingButtonTapped() {
        let nextVC = SetSoundVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
        // '소리 설정' 버튼이 탭되었을 때의 로직 구현
        print("소리 설정 화면으로 이동합니다.")
        // 여기에 소리 설정 화면으로 이동하는 코드 추가
    }
}

