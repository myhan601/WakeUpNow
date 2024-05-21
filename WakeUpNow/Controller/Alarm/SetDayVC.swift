//
//  SetDayVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

protocol SetDayVCDelegate: AnyObject {
    func didSelectDays(_ selectedDays: [String])
}

class SetDayVC: UIViewController {
    weak var delegate: SetDayVCDelegate?
    var selectedDays = [String]()
    var tableView: UITableView!
    let days = ["일", "월", "화", "수", "목", "금", "토"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        self.title = "반복"
        view.backgroundColor = ColorPalette.wakeLightBeige
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(goBack))
        // 네비게이션바 배경과 구분선을 투명하게 만듭니다.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.layer.borderWidth = 0.7
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.cornerRadius = 10
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(315)
        }
    }
    
    @objc func goBack() {
        delegate?.didSelectDays(selectedDays)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SetDayVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let day = days[indexPath.row]
        cell.textLabel?.text = "\(day)요일마다"
        cell.accessoryType = selectedDays.contains(day) ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SetDayVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        if let index = selectedDays.firstIndex(of: day) {
            selectedDays.remove(at: index)
        } else {
            selectedDays.append(day)
        }
        tableView.reloadData()
    }
}


