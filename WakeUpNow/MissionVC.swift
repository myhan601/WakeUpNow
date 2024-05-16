//
//  MissionVC.swift
//  WakeUpNow
//
//  Created by SAMSUNG on 5/13/24.
//

import UIKit
import SnapKit
import AVFoundation

class MissionVC: UIViewController {
    
    private var currentWord: Words?
    
    var ttangSoundPlayer: AVAudioPlayer?
    var correctSoundPlayer: AVAudioPlayer?
    
    let questionLabel = UILabel()
    let answer1 = UIButton()
    let answer2 = UIButton()
    let answer3 = UIButton()
    let progressView = UIProgressView()
    
    private func setConstrains() {
        
        view.addSubview(questionLabel)
        view.addSubview(answer1)
        view.addSubview(answer2)
        view.addSubview(answer3)
        view.addSubview(progressView)
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-400)
        }
        answer1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(500)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-280)
        }
        answer2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(600)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-180)
        }
        answer3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(700)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-80)
        }
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-750)
        }
    }
    
    private func setPage() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        questionLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        questionLabel.layer.borderWidth = 0
        questionLabel.layer.borderColor = UIColor.black.cgColor
        questionLabel.layer.masksToBounds = true
        questionLabel.layer.cornerRadius = 10
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.boldSystemFont(ofSize: 35)
        
        answer1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        answer1.layer.borderWidth = 1
        answer1.layer.borderColor = UIColor.black.cgColor
        answer1.layer.cornerRadius = 10
        answer1.setTitleColor(.black, for: .normal)
        answer1.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        answer2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        answer2.layer.borderWidth = 1
        answer2.layer.borderColor = UIColor.black.cgColor
        answer2.layer.cornerRadius = 10
        answer2.setTitleColor(.black, for: .normal)
        answer2.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        answer3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        answer3.layer.borderWidth = 1
        answer3.layer.borderColor = UIColor.black.cgColor
        answer3.layer.cornerRadius = 10
        answer3.setTitleColor(.black, for: .normal)
        answer3.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        progressView.trackTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        progressView.progressTintColor = .systemBlue
        progressView.progress = 0.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPage()
        setConstrains()
        fetchRandom()
        setTtangSound()
        setCorrectSound()
    }
    
    //APIDataManager 호출하기
    private func fetchRandom() {
        APIDataManager.shared.readAPI { [ weak self ] result in
            switch result {
            case.success(let word):
                self?.currentWord = word
                DispatchQueue.main.async {
                    self?.updateQuestion()
                }
            case .failure(let error):
                print("MissionPage Error: \(error)")
            }
        }
    }
    
    private func updateQuestion() {
        //questionLabel에 meaning랜덤으로 띄우기
        guard let question = currentWord else {
            print("No word")
            return
        }
        questionLabel.text = question.meaning
        
        //세 개의 보기 중에 랜덤한 위치에 정답 배치
        let correctAnswer = [answer1, answer2, answer3].randomElement()
        correctAnswer?.setTitle(question.furigana, for: .normal)
        
        //정답인 아닌 다른 보기들 배치
        var noAnswer = [String]()
        while noAnswer.count < 2 {
            guard let dummyAnswer = getDummyWord() else {
                continue
            }
            if dummyAnswer != question.furigana && !noAnswer.contains(dummyAnswer) {
                noAnswer.append(dummyAnswer)
            }
        }
        
        let otherAnswer = [answer1, answer2, answer3].filter { $0 != correctAnswer }
        for (index, button) in otherAnswer.enumerated() {
            button?.setTitle(noAnswer[index], for: .normal)
        }
    }
    
    //틀린 보기를 위한 더미데이터
    private func getDummyWord() -> String? {
        let dummyWord = [ "気立て", "差額", "青白い", "届け", "吃逆", "知る", "意地悪", "グラフ", "収容", "曖昧", "パンク", "洗う", "規準", "テーブル", "あなた" ]
        return dummyWord.randomElement()
    }
    
    //보기 버튼 클릭 시 실행되는 액션
    @objc private func clickButton(_ sender: UIButton) {
        guard let selectedWord = sender.titleLabel?.text else {
            return
        }
        //정답 버튼 클릭 시
        if selectedWord == currentWord?.furigana {
            sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            correctSoundPlayer?.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.successScreen()
            }
        } else {
            //틀린 버튼 클릭 시
            sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            ttangSoundPlayer?.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.resetScreen()
            }
        }
    }
    
    //정답 버튼 클릭 시 사전페이지로
    private func successScreen() {
        let successVC = MissionSuccessVC()
        successVC.modalPresentationStyle = .fullScreen
        present(successVC, animated: true, completion: nil)
    }
    
    //틀린 버튼 클릭 시 다른 문제로
    private func resetScreen() {
        questionLabel.text = nil
        answer1.setTitle(nil, for: .normal)
        answer2.setTitle(nil, for: .normal)
        answer3.setTitle(nil, for: .normal)
        answer1.backgroundColor = UIColor.clear
        answer2.backgroundColor = UIColor.clear
        answer3.backgroundColor = UIColor.clear
        fetchRandom()
    }
    
    //"땡"소리 삽입
    private func setTtangSound() {
        guard let path = Bundle.main.path(forResource: "ttang.wav", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            ttangSoundPlayer = try AVAudioPlayer(contentsOf: url)
            ttangSoundPlayer?.prepareToPlay()
        } catch {
            print("file Error")
        }
    }
    
    private func setCorrectSound() {
        guard let path = Bundle.main.path(forResource: "correct.wav", ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)
        do {
            correctSoundPlayer = try AVAudioPlayer(contentsOf: url)
            correctSoundPlayer?.prepareToPlay()
        } catch {
            print("file Error2")
        }
    }
}


//#Preview {
//    MissionVC()
//}
