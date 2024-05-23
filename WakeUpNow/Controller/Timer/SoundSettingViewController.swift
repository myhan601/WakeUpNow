//
//  SoundSettingViewController.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/20/24.
//


import UIKit
import SnapKit

protocol SoundSettingDelegate: AnyObject {
    func setAlarmSound(named soundName: String)
}

class SoundSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: SoundSettingDelegate?
    
    let soundOptions = ["Alarm", "Apex", "Ascending", "Bark", "Beacon", "Bell Tower", "Blues", "Boing", "Bullentin", "By The Seaside", "Chimes", "Circuit"]
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorPalette.wakeLightBeige
        
        configureTableView()
        configureNavigationBar()
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false // 스크롤 비활성화
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "soundCell") // 셀 등록
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // 컨텐츠 인셋 조정
//        tableView.layer.borderWidth = 0.7 // 테이블뷰의 테두리 너비
//        tableView.layer.borderColor = UIColor.gray.cgColor // 테이블뷰의 테두리 색상
        tableView.layer.cornerRadius = 10 // 테이블뷰의 모서리 둥글기
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 부모 뷰의 중앙에 위치
            make.top.equalToSuperview().offset(100) // 상단에서 100포인트 떨어진 위치
            make.width.equalToSuperview().multipliedBy(0.8) // 부모 뷰 너비의 80% 만큼
            make.height.equalTo(540)
        }
    }
    
    @objc func goBack() {
            dismiss(animated: true, completion: nil)
        }
        
        private func configureNavigationBar() {
            self.title = "사운드"
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
            // 네비게이션바 배경과 구분선을 투명하게 만듭니다.
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
        cell.textLabel?.text = soundOptions[indexPath.row]
        cell.backgroundColor = ColorPalette.wakeBeige
        cell.textLabel?.textColor = ColorPalette.wakeDarkGray
        
        if indexPath.row == 0 {
            cell.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        } else if indexPath.row == soundOptions.count - 1 {
            cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        } else {
            cell.roundCorners(corners: [], radius: 0.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSound = soundOptions[indexPath.row]
        delegate?.setAlarmSound(named: selectedSound)
        dismiss(animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}


//
//  SetSoundVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//



//    var tableView: UITableView!
//    let sounds = ["Alarm", "Apex", "Ascending", "Bark", "Beacon", "Bell Tower", "Blues", "Boing", "Bullentin", "By The Seaside", "Chimes", "Circuit"]
//    var selectedSound: String?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = ColorPalette.wakeLightBeige
//        
//        configureTableView()
//        configureNavigationBar()
//    }
//    
//    @objc func goBack() {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    private func configureNavigationBar() {
//        self.title = "사운드"
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
//        // 네비게이션바 배경과 구분선을 투명하게 만듭니다.
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//    }
//    
//    private func configureTableView() {
//        tableView = UITableView(frame: .zero, style: .plain)
//        tableView.isScrollEnabled = false // 스크롤 비활성화
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "soundCell") // 셀 등록
//        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0) // 컨텐츠 인셋 조정
//        tableView.layer.borderWidth = 0.7 // 테이블뷰의 테두리 너비
//        tableView.layer.borderColor = UIColor.gray.cgColor // 테이블뷰의 테두리 색상
//        tableView.layer.cornerRadius = 10 // 테이블뷰의 모서리 둥글기
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview() // 부모 뷰의 중앙에 위치
//            make.top.equalToSuperview().offset(100) // 상단에서 100포인트 떨어진 위치
//            make.width.equalToSuperview().multipliedBy(0.8) // 부모 뷰 너비의 80% 만큼
//            make.height.equalTo(540)
//        }
//    }
//}
//
//// MARK: - UITableViewDelegate
//extension SetSoundVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedSound = sounds[indexPath.row]
//        tableView.reloadData()
//        
//        // 델리게이트에 선택된 사운드를 전달합니다.
//        delegate?.didSelectSound(selectedSound ?? "nil")
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension SetSoundVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        sounds.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
//        let sound = sounds[indexPath.row]
//        cell.textLabel?.text = "\(sound)" // 왼쪽 여백 추가
//        cell.accessoryType = (sound == selectedSound) ? .checkmark : .none
//        return cell
//    }
//}

