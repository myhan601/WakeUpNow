# WakeUpNow

## 프로젝트 목적

### 프로젝트 명
- 일어NOW

### 프로젝트 설명
> 저희는 일어NOW라는 어플을 제작해보았습니다. 
일어NOW는 일본어 문제를 풀어야만 알람을 끌 수 있는 미션 알람 앱으로, 일본어를 뜻하는 일어와 지금이라는 뜻의 영문 Now를 합쳐 마치 일어나! 라고하는 것처럼 들리도록 유도해 이중적인 의미를 담았습니다. 

### 프로젝트 기간
- 24.05.13 ~ 24.05.23

### 담당파트
- 알람 기능 : 한철희
- 스톱워치 기능 : 서수영
- 타이머 기능 : 서혜림
- 미션 기능 : 박윤희

## 시연 영상
[시연 영상](https://youtu.be/aMisCOA0NTM)

## 와이어프레임
![와이어프레임](https://github.com/myhan601/WakeUpNow/assets/59227948/1d44a576-a410-4828-b27e-387d64e623eb)

## 컬러 팔렛 시안
<img src="https://github.com/myhan601/WakeUpNow/assets/59227948/46dc6de4-02b6-4907-a9d5-7a039ecb71d0" width="800">


## 페이지 기능별 소개 
### 탭바 & 알람 페이지
<img src="https://github.com/myhan601/WakeUpNow/assets/59227948/fb67aaff-57ed-4252-9e67-5355d818e722" width="800">

### 기능설명
먼저 탭바와 알람페이지는 철희님이 구현해주셨습니다.
 - 탭바에 연결되는 3개 페이지에 네비게이션을 적용시켜 원활하게 화면이 전환되도록 구현했습니다. 
 - 알람 페이지에서는 PickerView에 무한 스크롤 기능을 적용하여 사용자가 원하는 시간을 설정할 수 있도록 하였습니다.
 - 설정 시 현재 시간과 동일한 시간이 선택된 경우, 알럿 창을 통해 사용자에게 경고를 표시합니다.
 또한, UserNotifications 프레임워크를 사용하여 앱이 백그라운드 상태에서도 사용자에게 알람이 표시될 수 있도록 구현하였습니다.

---

### 스톱워치 페이지
<img src="https://github.com/myhan601/WakeUpNow/assets/59227948/9ee6cd92-0327-42b4-89b2-1855b421489d" width="800">

### 기능설명
다음으로 스톱워치 페이지 입니다.
 - 스톱워치 페이지는 수영님이 구현해주셨습니다.
 - Timer루프 기능으로 0.01초의 단위시간마다 누적시간을 계산해 표시할 수 있도록 했습니다.
 - UITableView를 사용하여 기록된 랩 타임을 목록으로 표시하며, 각 랩 타임을 표시하기 위해 커스텀 셀을 사용하기도 했습니다.
---

### 타이머 페이지
<img src="https://github.com/myhan601/WakeUpNow/assets/59227948/a6ca2bd0-a95c-4b4c-81fa-40920305af8d" width="800">

### 기능설명
타이머 페이지는 혜림님이 구현해주셨습니다. 
- 사용자가 시간을 설정할 수 있도록 타이머 설정 뷰 컨트롤러를 HalfModalView와 PickerView로 표시합니다.
- CAShapeLayer를 사용하여 원형 커스텀 레이아웃을 만들어 시간의 흐름에 따른 progress를 업데이트 하도록 구현했습니다.
- 또한, 백그라운드에서도 타이머가 작동될 수 있도록 구현했습니다. 

---

### 미션 페이지
<img src="https://github.com/myhan601/WakeUpNow/assets/59227948/b91942bf-249c-4918-a85f-e4ec65ea5d74" width="800">

### 기능설명
- 마지막으로 미션페이지는 윤희님이 구현해주셨습니다.
- 미션 페이지의 필요한 데이터는 APIDataManager를 통해 가져왔으며, 유저의 점수 정보는 CoreData를 이용해 저장했습니다.
- 시연 영상에서 보신 것처럼, 지정된 시간 내에 문제를 풀 수 있도록 progressBar를 사용해 구현했습니다.
- 또한, 정답을 맞췄을 때와 틀렸을 때 효과음을 삽입하기 위해 AVAudioPlayer 클래스로 오디오 파일을 재생할 수 있도록 구현했습니다. 
---

### 팀원 소감

#### 한철희

- #### 병합 과정에서의 충돌 해결
  - 프로젝트 진행 중, GitHub 병합 과정에서 다수의 충돌이 발생하였습니다. 팀원들과 화면을 공유하면서 이를 해결하였으며, 초반 파일 구조 변경과 많은 변경점 때문에 충돌이 발생한 것으로 생각됩니다. 이후 큰 이슈 없이 진행되었으며, 초반 파일 구조와 기본이 되는 `develop` 브랜치 생성에 더 신경 써야겠다는 교훈을 얻었습니다.

- #### 로컬 알림 구현
  - 로컬 알림 구현 시, `UserNotifications`를 사용하여 알람 소리를 설정한 소리로 변경하고 특정 액션 전까지 무한 반복하도록 하였습니다. 그러나 설정한 시간 이외에 알림이 동작하는 문제가 발생하여 원인을 찾고 있습니다.

- #### 화면 전환 이슈
  - `MissionSuccessVC`에서 화면 전환 시 네비게이션을 사용하려 했으나, 네비게이션 값이 `nil`로 나타나는 문제로 모달 뷰를 사용하여 해결하였습니다.

- #### 정답 처리 기능 구현
  - `MissionVC`의 정답 처리 기능 구현 시 `AppDelegate`의 `stopAlarmSound()`를 호출하여 문제를 해결하였으나, 더 나은 방법에 대한 아쉬움이 남습니다.

- #### 회고 및 개선 사항
  - 프로젝트를 진행하며 기능을 추가할수록 더 많은 구현 요소들이 생겨났고, 설계 계획이 체계적이지 못한 부분에 대한 아쉬움이 남습니다. 다음 프로젝트에서는 더 큰 규모로 진행될 예정이므로, 이번 회고를 통해 얻은 교훈을 바탕으로 개선할 것입니다.

---

#### 서수영

- #### GitHub 및 코드 이해
  - 협업 과정에서 GitHub와 타인의 코드를 이해하는 것이 어려웠으나, 다양한 기능과 방법을 배울 수 있었습니다. 특히, Figma를 사용한 디자인 협업이 인상 깊었고, Figma 사용법을 많이 배울 수 있었습니다.

- #### 타이머 및 GitHub 협업
  - 타이머 사용법과 GitHub 협업에 대한 이해가 부족했으나, 팀원들의 도움으로 문제를 해결할 수 있었습니다. 이 경험으로 인해 향후 협업이 더 수월해질 것으로 기대합니다.

- #### 작업 계획 및 진행
  - 계획에 맞춰 작업을 진행하는 것이 가장 어려웠지만, 앞으로 충분한 설계와 경험을 통해 보다 체계적인 계획을 세울 것입니다.

---

#### 박윤희

- #### GitHub 병합 과정에서의 어려움
  - 이번 프로젝트에서 GitHub 병합 과정에서의 충돌(conflict), SnapKit 사용, 파일 이탈 등의 문제가 발생했습니다. 이러한 문제들은 화면 공유와 팀원들, 튜터님의 도움으로 해결할 수 있었습니다.

- #### 화면 전환 및 API 연결
  - 코드 미숙으로 인해 화면 전환과 API 연결에서 어려움을 겪었습니다. 이를 해결하기 위해 화면 전환 방식을 모달 형식으로 통일하고, API 연결에 대한 학습을 통해 문제를 해결하였습니다. 또한, 더미 데이터를 생성하여 연결의 어려운 부분을 보완하였습니다.

- #### 협업을 통한 학습
  - 이번 프로젝트를 통해 혼자 구현하는 것과 달리 협업하면서 많은 것을 배울 수 있었습니다. GitHub 병합의 어려움을 겪으면서 코드 협업의 중요성을 깨달았습니다. 협업하는 과정에서 많은 것을 배우고 느끼는 시간이었습니다.

- #### MissionSuccessVC에서 TabBarVC로의 화면 전환
  - MissionSuccessVC에서 TabBarVC로의 화면 전환에 어려움을 겪었으나, 화면 전환 방식을 통일하고 `presentingViewController`를 사용하여 여러 화면을 한 번에 닫을 수 있도록 구현함으로써 문제를 해결할 수 있었습니다. 

---

#### 서혜림

- #### 타이머 기능 구현
  - 이번 타이머 기능들을 구현하는 과정에서, 아이폰의 시계 앱 타이머 기능을 많이 참고하였습니다. 단순한 기능이라 생각했던 부분에서도 많은 오류 해결과 학습이 필요했습니다.

- #### 사운드 파일을 이용한 알람 소리 재생
  - 특히, 사운드 파일을 이용해 알람 소리를 재생하고 설정하는 부분에서 어려움을 겪었습니다. 파일 접근 방법과 사운드 재생 메소드 사용이 익숙하지 않아 구현하는 데 시간이 많이 걸렸습니다. 관련 코드를 여러 번 수정하고 다시 구현하면서 문제를 해결했지만, 정확한 원인을 파악하지 못한 점이 아쉽습니다.

- #### 오토레이아웃 오류
  - 오토레이아웃 설정에서도 오류가 발생하여, 새로운 UI를 추가할 때마다 문제가 생기는 경우가 많았습니다. 수정 전후로 커밋을 자주 하여 코드의 오류나 변경 사항을 파악하는 것이 중요하다는 것을 다시 깨달았습니다.

- #### 사용자 친화적 타이머 디스플레이
  - 사용자들이 타이머를 직관적으로 이용할 수 있도록, 서클러 타이머 뷰와 카운트다운 레이블을 통해 남은 시간을 표시하였습니다. 


