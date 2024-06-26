//
//  SetSoundVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//


import UIKit
import SnapKit

protocol SetSoundVCDelegate: AnyObject {
    func didSelectSound(_ sound: String)
}

class SetSoundVC: UIViewController {
    weak var delegate: SetSoundVCDelegate?
    var tableView: UITableView!
    let sounds = ["Alarm", "Apex", "Ascending", "Bark", "Beacon", "Bell Tower", "Blues", "Boing", "Bullentin", "By The Seaside", "Chimes", "Circuit"]
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
            make.left.equalToSuperview().offset(20) // 왼쪽에서 20만큼 간격
            make.right.equalToSuperview().offset(-20) // 오른쪽에서 20만큼 간격
            make.height.equalTo(540)
        }
    }
}

// MARK: - UITableViewDelegate
extension SetSoundVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSound = sounds[indexPath.row]
        tableView.reloadData()
        
        // 델리게이트에 선택된 사운드를 전달합니다.
        delegate?.didSelectSound(selectedSound ?? "nil")
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
        cell.backgroundColor = ColorPalette.wakeBeige
        cell.textLabel?.text = "\(sound)" // 왼쪽 여백 추가
        cell.accessoryType = (sound == selectedSound) ? .checkmark : .none
        return cell
    }
}

