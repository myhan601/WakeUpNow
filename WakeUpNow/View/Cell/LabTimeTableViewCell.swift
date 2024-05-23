
import UIKit
import SnapKit

class LabTimeTableViewCell: UITableViewCell {

    static let cellId = "CellId"

    var indexLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: UIFont.Weight.regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() {
        contentView.addSubview(indexLabel)
        contentView.addSubview(timeLabel)
    }

    func configureLayout() {
        contentView.backgroundColor = ColorPalette.wakeBeige

        let inset = CGFloat(10)
        indexLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(inset)
            $0.width.equalTo(40)
        }

        timeLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

