//
//  AlarmPageVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit

class AlarmPageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        
        // 레이블에 표시될 텍스트 설정
        label.text = "안녕하세요, 레이블입니다!"
        
        // 레이블의 위치와 크기 설정
        label.frame = CGRect(x: 20, y: 20, width: 300, height: 20)
        
        // 레이블의 텍스트 정렬 설정
        label.textAlignment = .center
        
        // 레이블을 뷰에 추가
        self.view.addSubview(label)
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
