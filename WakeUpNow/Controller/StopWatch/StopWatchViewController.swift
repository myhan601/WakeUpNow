

import UIKit
import SnapKit

class StopWatchViewController: UIViewController {

    var timer: Timer!
    var elapsedTime: TimeInterval = 0

    var isRunning: Bool = false

    var labTimeList: [String] = []

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00.00"
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 60, weight: UIFont.Weight.regular)

        return label
    }()

    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        button.backgroundColor = ColorPalette.wakeBeige
        button.setTitleColor(ColorPalette.wakeRed, for: .normal)

        button.setTitle("랩", for: .normal)
        button.isEnabled = false

        button.addTarget(self, action: #selector(labResetAction), for: .touchUpInside)

        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 50
        button.clipsToBounds = true
        button.backgroundColor = ColorPalette.wakeLightSky
        button.setTitleColor(ColorPalette.wakeBlue, for: .normal)

        button.setTitle("시작", for: .normal)

        button.addTarget(self, action: #selector(startStopTimer), for: .touchUpInside)

        return button
    }()

    lazy var labTimeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorPalette.wakeBeige
        tableView.register(LabTimeTableViewCell.self, forCellReuseIdentifier: LabTimeTableViewCell.cellId)

        tableView.layer.cornerRadius = 15
        tableView.clipsToBounds = true

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.wakeLightBeige

        configureHierarchy()
        configureLayout()
    }

    private func configureHierarchy() {
        view.addSubview(timeLabel)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(labTimeTableView)
    }

    private func configureLayout() {
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }

        leftButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(40)
            $0.height.width.equalTo(100)
            $0.leading.equalToSuperview().inset(20)
        }

        rightButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(40)
            $0.height.width.equalTo(100)
            $0.trailing.equalToSuperview().inset(20)
        }

        labTimeTableView.snp.makeConstraints {
            $0.top.equalTo(rightButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc 
    private func labResetAction() {
        if isRunning {
            labTimeList.append(self.timeLabel.text ?? "")
        }else {
            labTimeList = []
            self.timeLabel.text = "00:00.00"
            self.elapsedTime = 0
            self.leftButton.setTitle("랩", for: .normal)
            leftButton.isEnabled = false
        }
        labTimeTableView.reloadData()
    }

    @objc
    private func startStopTimer() {
        if isRunning {
            timer.invalidate()
            self.rightButton.setTitle("시작", for: .normal)
            self.rightButton.setTitleColor(ColorPalette.wakeBlue, for: .normal)

            self.rightButton.backgroundColor = ColorPalette.wakeLightSky
            self.leftButton.setTitle("재설정", for: .normal)
        }else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] timer in
                // Update the elapsed time
                self?.elapsedTime += timer.timeInterval

                // Format the elapsed time as a stopwatch time
                let minutes = Int(self?.elapsedTime ?? 0) / 60 % 60
                let seconds = Int(self?.elapsedTime ?? 0) % 60
                let milliseconds = Int((self?.elapsedTime ?? 0) * 100) % 100

                // Update the label with the formatted time
                self?.timeLabel.text = String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
                self?.rightButton.setTitle("중단", for: .normal)
                self?.rightButton.setTitleColor(ColorPalette.wakeRed, for: .normal)
                self?.rightButton.backgroundColor = ColorPalette.wakeBeige
                self?.leftButton.setTitle("랩", for: .normal)
            })
        }
        isRunning.toggle()
        leftButton.isEnabled = true
        // Update the button text
    }
}

extension StopWatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labTimeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LabTimeTableViewCell.cellId, for: indexPath) as! LabTimeTableViewCell

        cell.indexLabel.text = "랩 \(labTimeList.count - indexPath.row)"
        cell.timeLabel.text = labTimeList.reversed()[indexPath.row]

        return cell
    }
}

