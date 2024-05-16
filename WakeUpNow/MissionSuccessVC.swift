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
        
    let correctLabel = UILabel()
    let dictionaryLabel = UILabel()
    let backButton = UIButton()
    
    private func setConstrains() {
        
        view.addSubview(correctLabel)
        view.addSubview(dictionaryLabel)
        view.addSubview(backButton)
        
        correctLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-700)
        }
        dictionaryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-250)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-280)
            make.bottom.equalToSuperview().offset(-750)
        }
    }
    
    private func setPage() {
        
        view.backgroundColor = .white
        
        correctLabel.text = "정답!!"
        correctLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        correctLabel.textAlignment = .center
        correctLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        dictionaryLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        dictionaryLabel.layer.borderWidth = 1
        dictionaryLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dictionaryLabel.layer.cornerRadius = 10
        
        backButton.setTitle("메인으로", for: .normal)
        backButton.setTitleColor(.lightGray, for: .normal)
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPage()
        setConstrains()
    }

    @objc private func tappedBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

//#Preview {
//    MissionSuccessVC()
//}
