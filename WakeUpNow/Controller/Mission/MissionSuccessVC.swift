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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-650)
        }
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
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
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-180)
        }
        correctquestion.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(560)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-240)
        }
    }
    
    private func setPage() {
        
        view.backgroundColor = ColorPalette.wakeLightBeige
        
        correctLabel.text = "정 답 ! !"
        correctLabel.textColor = ColorPalette.wakeDeepNavy
        correctLabel.textAlignment = .center
        correctLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        scoreLabel.backgroundColor = ColorPalette.wakeBeige
        scoreLabel.layer.cornerRadius = 10
        scoreLabel.layer.masksToBounds = true
        scoreLabel.numberOfLines = 0
        scoreLabel.textColor = ColorPalette.wakeDeepNavy
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        backButton.setTitle("메인으로", for: .normal)
        backButton.setTitleColor(ColorPalette.wakeGray, for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
        wrongCountLabel.backgroundColor = ColorPalette.wakeBeige
        wrongCountLabel.layer.cornerRadius = 10
        wrongCountLabel.layer.masksToBounds = true
        wrongCountLabel.text = "틀린 개수 : \(wrongCount)"
        wrongCountLabel.textColor = ColorPalette.wakeDeepNavy
        wrongCountLabel.textAlignment = .center
        wrongCountLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        correctquestion.backgroundColor = ColorPalette.wakeBeige
        correctquestion.layer.cornerRadius = 10
        correctquestion.layer.masksToBounds = true
        correctquestion.text = "맞힌 단어 : \(correctWord!.furigana)"
        correctquestion.textColor = ColorPalette.wakeDeepNavy
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPage()
        setConstrains()
        coreDataScore()
    }
    
    //버튼 누르면 알람페이지로 이동
    @objc private func tappedBackButton() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil) //presentingViewController 한 개에 페이지 하나
    }
}
//#Preview {
//    MissionSuccessVC()
//}
