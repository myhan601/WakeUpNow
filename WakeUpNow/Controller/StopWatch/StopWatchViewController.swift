

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
        button.layer.cornerRadius = 34
        button.clipsToBounds = true
        button.backgroundColor = .systemGray

        button.setTitle("랩", for: .normal)
        button.isEnabled = false

        button.addTarget(self, action: #selector(labResetAction), for: .touchUpInside)

        return button
    }()

    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 34
        button.clipsToBounds = true
        button.backgroundColor = .systemGray

        button.setTitle("시작", for: .normal)

        button.addTarget(self, action: #selector(startStopTimer), for: .touchUpInside)

        return button
    }()

    lazy var labTimeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = ColorPalette.second
        tableView.register(LabTimeTableViewCell.self, forCellReuseIdentifier: LabTimeTableViewCell.cellId)

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.primary

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
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        leftButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(40)
            $0.height.width.equalTo(68)
            $0.leading.equalToSuperview().inset(8)
        }

        rightButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(40)
            $0.height.width.equalTo(68)
            $0.trailing.equalToSuperview().inset(8)
        }

        labTimeTableView.snp.makeConstraints {
            $0.top.equalTo(rightButton.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
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
            self.rightButton.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: .normal)

            self.rightButton.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
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
                self?.rightButton.setTitleColor(#colorLiteral(red: 1, green: 0.1656707525, blue: 0.2545326352, alpha: 1), for: .normal)
                self?.rightButton.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
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

//        if labTimeList.count >= 3 {
//            if labTimeList.reversed()[indexPath.row] == labTimeList.min() {
//                cell.indexLabel.textColor = .green
//                cell.timeLabel.textColor = .green
//            }
//            if labTimeList.reversed()[indexPath.row] == labTimeList.max() {
//                cell.indexLabel.textColor = .red
//                cell.timeLabel.textColor = .red
//            }
//        }

        return cell
    }
}

