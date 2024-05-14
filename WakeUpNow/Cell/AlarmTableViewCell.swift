//
//  AlarmTableViewCell.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/14/24.
//

import UIKit
import SnapKit

// 뷰 모델 정의
struct AlarmViewModel {
    let meridiem: String
    let time: String
    let isActive: Bool
}

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCell"
    
    private let meridiemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        // 추가적인 라벨 설정
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        // 추가적인 라벨 설정
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let switchControl = UISwitch()
        // 스위치 설정
        return switchControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // 뷰에 요소들 추가
        addSubview(meridiemLabel)
        addSubview(timeLabel)
        addSubview(alarmSwitch)
        
        // SnapKit을 사용한 레이아웃 설정
        meridiemLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0) // 왼쪽 여백을 0으로 설정
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(meridiemLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.lessThanOrEqualTo(alarmSwitch.snp.left).offset(-10)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    // 셀의 데이터를 설정하는 메서드
    func configure(with viewModel: AlarmViewModel) {
        meridiemLabel.text = viewModel.meridiem
        timeLabel.text = viewModel.time
        alarmSwitch.isOn = viewModel.isActive
    }
}



