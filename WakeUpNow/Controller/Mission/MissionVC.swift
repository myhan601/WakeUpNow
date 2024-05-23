////
////  MissionVC.swift
////  WakeUpNow
////
////  Created by SAMSUNG on 5/13/24.
////
//
//import UIKit
//import SnapKit
//import AVFoundation
//
////protocol선언
//protocol MissionVCDelegate: AnyObject {
//    func missionVCDelegate()
//}
//
//class MissionVC: UIViewController {
//    
//    weak var delegate: MissionVCDelegate?
//    private var currentWord: Words?
//    var Core = CoreDataManager()
//    
//    private var score: Int = 0
//    var wrongCount: Int = 0
//    var time: Float = 0.0
//    var timer = Timer()
//    
//    var ttangSoundPlayer: AVAudioPlayer?
//    var correctSoundPlayer: AVAudioPlayer?
//    
//    let questionLabel = UILabel()
//    let answer1 = UIButton()
//    let answer2 = UIButton()
//    let answer3 = UIButton()
//    //타이머 바
//    let progressView = UIProgressView()
//    
//    private func setConstrains() {
//        
//        view.addSubview(questionLabel)
//        view.addSubview(answer1)
//        view.addSubview(answer2)
//        view.addSubview(answer3)
//        view.addSubview(progressView)
//        
//        questionLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(100)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-400)
//        }
//        answer1.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(500)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-280)
//        }
//        answer2.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(600)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-180)
//        }
//        answer3.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(700)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-80)
//        }
//        progressView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(50)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-800)
//        }
//    }
//    
//    private func setPage() {
//        
//        view.backgroundColor = #colorLiteral(red: 0.9594840407, green: 0.9445981383, blue: 0.9232942462, alpha: 1)
//        
//        questionLabel.backgroundColor = #colorLiteral(red: 0.890609324, green: 0.86582762, blue: 0.8187091351, alpha: 1)
//        questionLabel.layer.masksToBounds = true
//        questionLabel.layer.cornerRadius = 10
//        questionLabel.textAlignment = .center
//        questionLabel.numberOfLines = 0
//        questionLabel.font = UIFont.boldSystemFont(ofSize: 35)
//        
//        answer1.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        answer1.layer.cornerRadius = 10
//        answer1.setTitleColor(.black, for: .normal)
//        answer1.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
//        
//        answer2.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        answer2.layer.cornerRadius = 10
//        answer2.setTitleColor(.black, for: .normal)
//        answer2.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
//        
//        answer3.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        answer3.layer.cornerRadius = 10
//        answer3.setTitleColor(.black, for: .normal)
//        answer3.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
//        
//        progressView.progressViewStyle = .default
//        resetTimer()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setPage()
//        setConstrains()
//        fetchRandom()
//        setTtangSound()
//        setCorrectSound()
//        
//    }
//    
//    //APIDataManager 호출하기
//    private func fetchRandom() {
//        APIDataManager.shared.readAPI { [ weak self ] result in
//            switch result {
//            case.success(let word):
//                self?.currentWord = word
//                DispatchQueue.main.async {
//                    self?.updateQuestion()
//                }
//            case .failure(let error):
//                print("MissionPage Error: \(error)")
//            }
//        }
//    }
//    
//    private func updateQuestion() {
//        //questionLabel에 meaning랜덤으로 띄우기
//        guard let question = currentWord else {
//            print("No word")
//            return
//        }
//        questionLabel.text = question.meaning
//        
//        //세 개의 보기 중에 랜덤한 위치에 정답 배치
//        let correctAnswer = [answer1, answer2, answer3].randomElement()
//        correctAnswer?.setTitle(question.furigana, for: .normal)
//        
//        //정답인 아닌 다른 보기들 배치
//        var noAnswer = [String]()
//        while noAnswer.count < 2 {
//            guard let dummyAnswer = getDummyWord() else {
//                continue
//            }
//            if dummyAnswer != question.furigana && !noAnswer.contains(dummyAnswer) {
//                noAnswer.append(dummyAnswer)
//            }
//        }
//        
//        let otherAnswer = [answer1, answer2, answer3].filter { $0 != correctAnswer }
//        for (index, button) in otherAnswer.enumerated() {
//            button?.setTitle(noAnswer[index], for: .normal)
//        }
//    }
//    
//    //오답 보기를 위한 더미데이터
//    private func getDummyWord() -> String? {
//        let dummyWord = [ "気立て", "差額", "青白い", "届け", "吃逆", "知る", "意地悪", "グラフ", "収容", "曖昧", "パンク", "洗う", "規準", "テーブル", "あなた" ]
//        return dummyWord.randomElement()
//    }
//    
//    //정답 버튼 클릭 시 사전페이지로
//    private func successScreen() {
//        let successVC = MissionSuccessVC()
//        successVC.modalPresentationStyle = .overFullScreen
//        successVC.score = self.score //Total점수
//        successVC.correctWord = self.currentWord //정답 맞힌 단어
//        successVC.wrongCount = self.wrongCount //틀린 개수
//        present(successVC, animated: true, completion: nil)
//        
//        Core.saveUser(user: User(score: self.score))
//        
//        //미션페이지의 작업 완료를 알림
//        self.delegate?.missionVCDelegate()
////        print(delegate)
//    }
//    
//    //오답 버튼 클릭 시 다른 문제로
//    private func resetScreen() {
//        questionLabel.text = nil
//        answer1.setTitle(nil, for: .normal)
//        answer2.setTitle(nil, for: .normal)
//        answer3.setTitle(nil, for: .normal)
//        answer1.setTitleColor(.black, for: .normal)
//        answer2.setTitleColor(.black, for: .normal)
//        answer3.setTitleColor(.black, for: .normal)
//        answer1.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        answer2.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        answer3.backgroundColor = #colorLiteral(red: 0.740773499, green: 0.7857543826, blue: 0.7978796959, alpha: 1)
//        fetchRandom()
//        resetTimer() //다른 문제로 넘어갔을 떄, progressBar도 초기화
//    }
//    
//    //progressBar 초기화
//    private func resetTimer() {
//        time = 0.0
//        timer.invalidate()
//        progressView.setProgress(time, animated: false)
//        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
//    }
//    
//    //오답 효과음
//    private func setTtangSound() {
//        guard let path = Bundle.main.path(forResource: "ttang.wav", ofType: nil) else { return }
//        let url = URL(fileURLWithPath: path)
//        do {
//            ttangSoundPlayer = try AVAudioPlayer(contentsOf: url)
//            ttangSoundPlayer?.prepareToPlay()
//        } catch {
//            print("file Error")
//        }
//    }
//    
//    //정답 효과음
//    private func setCorrectSound() {
//        guard let path = Bundle.main.path(forResource: "correct.wav", ofType: nil) else { return }
//        let url = URL(fileURLWithPath: path)
//        do {
//            correctSoundPlayer = try AVAudioPlayer(contentsOf: url)
//            correctSoundPlayer?.prepareToPlay()
//        } catch {
//            print("file Error2")
//        }
//    }
//    
//    //보기 버튼 클릭 시 실행되는 액션
//    @objc private func clickButton(_ sender: UIButton) {
//        guard let selectedWord = sender.titleLabel?.text else {
//            return
//        }
//        //정답 버튼 클릭 시
//        if selectedWord == currentWord?.furigana {
//            sender.backgroundColor = #colorLiteral(red: 0.1250983775, green: 0.4217019081, blue: 0.532646358, alpha: 1)
//            sender.setTitleColor(.white, for: .normal)
//            correctSoundPlayer?.play()
//            score += 5 //정답 클릭 시 점수 변동
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.successScreen() //정답 클릭 시 다른 액션보다 늦게
//            }
//        } else {
//            //오답 버튼 클릭 시
//            sender.backgroundColor = #colorLiteral(red: 0.745804131, green: 0.2601789236, blue: 0.2126921713, alpha: 1)
//            sender.setTitleColor(.white, for: .normal)
//            ttangSoundPlayer?.play()
//            wrongCount += 1 //오답 클릭 시 틀린 개수 증가
//            score -= 2 //오답 클릭 시 점수 변동
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                self.resetScreen()
//            }
//        }
//    }
//    
//    //progressBar 구현
//    @objc func setProgress() {
//        time += 0.0005
//        progressView.setProgress(time, animated: true)
//        if time >= 1.0 {
//            timer.invalidate()
//            resetScreen()
//        }
//    }
//}
//
//
////#Preview {
////    MissionVC()
////}
