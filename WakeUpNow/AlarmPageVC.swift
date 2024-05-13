//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class AlarmPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 레이블 생성
        let label = UILabel()
        
        // 레이블에 표시될 텍스트 설정
        label.text = "안녕하세요, 레이블입니다!"
        
        // 레이블의 텍스트 정렬 설정
        label.textAlignment = .center
        
        // 레이블을 뷰에 추가
        self.view.addSubview(label)
        
        // SnapKit을 사용하여 레이블의 위치와 크기 설정
        label.snp.makeConstraints { (make) in
            // 화면 중앙에 오도록 설정
            make.center.equalToSuperview()
            
            // 레이블의 너비와 높이 설정 (필요한 경우)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
