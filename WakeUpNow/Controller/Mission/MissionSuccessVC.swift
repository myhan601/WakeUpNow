//
//  MissionSuccessVC.swift
//  WakeUpNow
//
//  Created by SAMSUNG on 5/13/24.
//

import UIKit
import SnapKit

class MissionSuccessVC: UIViewController {
    
    private var currentWord: Words?
    var score: Int = 0
        
    let correctLabel = UILabel()
    let scoreLabel = UILabel()
    let backButton = UIButton()
    
    private func setConstrains() {

        view.addSubview(correctLabel)
        view.addSubview(scoreLabel)
        view.addSubview(backButton)
        
        correctLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-650)
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-300)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-280)
            make.bottom.equalToSuperview().offset(-750)
        }
    }
    
    private func setPage() {
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        correctLabel.text = "정답!!"
        correctLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correctLabel.textAlignment = .center
        correctLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        scoreLabel.backgroundColor = .clear
        scoreLabel.numberOfLines = 0
        scoreLabel.text = """
Total score

\(score)점
"""
        scoreLabel.textColor = #colorLiteral(red: 0, green: 0.4218143225, blue: 0.9270003438, alpha: 1)
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        backButton.setTitle("메인으로", for: .normal)
        backButton.setTitleColor(.lightGray, for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
    }
    
    private func setBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        view.addSubview(visualEffect)
        view.sendSubviewToBack(visualEffect)
        visualEffect.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBlur()
        setPage()
        setConstrains()
    }

    //버튼 누르면 알람페이지로 이동
    @objc private func tappedBackButton() {
        let arlmPage = AlarmPageVC()
        navigationController?.pushViewController(arlmPage, animated: true)
        print("연결확인")
    }
}

//#Preview {
//    MissionSuccessVC()
//}
