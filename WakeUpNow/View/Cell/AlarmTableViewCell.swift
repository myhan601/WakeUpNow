//
//  AlarmTableViewCell.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/14/24.
//

import UIKit
import SnapKit

protocol AlarmTableViewCellDelegate: AnyObject {
    func didTapCell(_ cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    static let identifier = "AlarmTableViewCell"
    
    @objc private func handleTap() {
        delegate?.didTapCell(self)
    }
    
    private let meridiemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 45, weight: .light)
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = ColorPalette.wakeBlue
        return switchControl
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.isHidden = true // 처음에는 숨겨진 상태
        return imageView
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(meridiemLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(alarmSwitch)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(memoLabel)
        
        alarmSwitch.addTarget(self, action: #selector(alarmSwitchValueChanged), for: .valueChanged)
        
        // SnapKit을 사용한 레이아웃 설정
        meridiemLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(0)
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(meridiemLabel.snp.right).offset(-7)
            make.centerY.equalToSuperview().offset(-10)
            make.right.lessThanOrEqualTo(alarmSwitch.snp.left).offset(-10)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20) // 화살표 크기 조정
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(meridiemLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func alarmSwitchValueChanged() {
        print("Switch value changed. isAlarmOn: \(alarmSwitch.isOn)")
    }
    
    @objc private func didTapCell() {
        delegate?.didTapCell(self)
    }
    
    // 셀의 데이터를 설정하는 메서드
    func configure(with alarm: Alarm) {
        meridiemLabel.text = alarm.amPm
        timeLabel.text = alarm.formattedTime
        alarmSwitch.isOn = alarm.isAlarmOn
        memoLabel.text = alarm.memo
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 편집 모드일 때 셀의 내용을 오른쪽으로 이동
        if isEditing {
            let editingOffset: CGFloat = 40.0
            contentView.transform = CGAffineTransform(translationX: editingOffset, y: 0)
            alarmSwitch.isHidden = true
            arrowImageView.isHidden = false
        } else {
            contentView.transform = CGAffineTransform.identity
            alarmSwitch.isHidden = false
            arrowImageView.isHidden = true
        }
    }
}
