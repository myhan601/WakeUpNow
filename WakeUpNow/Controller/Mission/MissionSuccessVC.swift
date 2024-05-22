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
    var Core = CoreDataManager()
    
    var correctWord: Words? //정답 맞춘 단어
    var score: Int = 0 //점수
    var wrongCount: Int = 0 //틀린 개수
        
    let correctLabel = UILabel()
    let scoreLabel = UILabel()
    let backButton = UIButton()
    let wrongCountLabel = UILabel()
    let correctquestion = UILabel()
    
    private func setConstrains() {

        view.addSubview(correctLabel)
        view.addSubview(scoreLabel)
        view.addSubview(backButton)
        view.addSubview(wrongCountLabel)
        view.addSubview(correctquestion)
        
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
        wrongCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(620)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-180)
        }
        correctquestion.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(560)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-240)
        }
    }
    
    private func setPage() {
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        correctLabel.text = "정 답 ! !"
        correctLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correctLabel.textAlignment = .center
        correctLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        scoreLabel.backgroundColor = #colorLiteral(red: 0.1250983775, green: 0.4217019081, blue: 0.532646358, alpha: 1)
        scoreLabel.layer.cornerRadius = 10
        scoreLabel.layer.masksToBounds = true
        scoreLabel.numberOfLines = 0
        scoreLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        backButton.setTitle("메인으로", for: .normal)
        backButton.setTitleColor(.lightGray, for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        wrongCountLabel.backgroundColor = #colorLiteral(red: 0.1250983775, green: 0.4217019081, blue: 0.532646358, alpha: 1)
        wrongCountLabel.layer.cornerRadius = 10
        wrongCountLabel.layer.masksToBounds = true
        wrongCountLabel.text = "틀린 개수 : \(wrongCount)"
        wrongCountLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        wrongCountLabel.textAlignment = .center
        wrongCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        correctquestion.backgroundColor = #colorLiteral(red: 0.1250983775, green: 0.4217019081, blue: 0.532646358, alpha: 1)
        correctquestion.layer.cornerRadius = 10
        correctquestion.layer.masksToBounds = true
        correctquestion.text = "맞힌 단어 : \(correctWord!.furigana)"
        correctquestion.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        correctquestion.textAlignment = .center
        correctquestion.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private func coreDataScore() {
        let totalScore = Core.readUser().reduce(0) { $0 + $1.score }
        
        scoreLabel.text = """
Total score

\(totalScore)점
"""
    }
    
    //배경 블러처리
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
        coreDataScore()
    }

    //버튼 누르면 알람페이지로 이동
    @objc private func tappedBackButton() {
        let arlmPage = TabBarVC()
        navigationController?.pushViewController(arlmPage, animated: true)
        print("연결확인")
    }
}

//#Preview {
//    MissionSuccessVC()
//}
