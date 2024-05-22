//
//  SetSoundVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//


import UIKit
import SnapKit

class SetSoundVC: UIViewController {
    
    var tableView: UITableView!
    let sounds = ["사운드1", "사운드2", "사운드3", "사운드4", "사운드5", "사운드6", "사운드7", "사운드8", "사운드9", "사운드10"]
    var selectedSound: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPalette.wakeLightBeige
        
        configureTableView()
        configureNavigationBar()
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureNavigationBar() {
        self.title = "사운드"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
        // 네비게이션바 배경과 구분선을 투명하게 만듭니다.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false // 스크롤 비활성화
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "soundCell") // 셀 등록
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // 컨텐츠 인셋 조정
        tableView.layer.borderWidth = 0.7 // 테이블뷰의 테두리 너비
        tableView.layer.borderColor = UIColor.gray.cgColor // 테이블뷰의 테두리 색상
        tableView.layer.cornerRadius = 10 // 테이블뷰의 모서리 둥글기
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 부모 뷰의 중앙에 위치
            make.top.equalToSuperview().offset(100) // 상단에서 100포인트 떨어진 위치
            make.width.equalToSuperview().multipliedBy(0.8) // 부모 뷰 너비의 80% 만큼
            make.height.equalTo(405)
        }
    }
}

// MARK: - UITableViewDelegate
extension SetSoundVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSound = sounds[indexPath.row]
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SetSoundVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
        let sound = sounds[indexPath.row]
        cell.textLabel?.text = "\(sound)" // 왼쪽 여백 추가
        cell.accessoryType = (sound == selectedSound) ? .checkmark : .none
        return cell
    }
}

