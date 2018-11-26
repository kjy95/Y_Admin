//
//  IMGrootViewController.swift
//  IAMGROOT
//
//  Created by 김지영 on 24/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class IMGrootViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var growingPlantButton: UIButton!
    @IBOutlet weak var ToolButton: UIButton!
    @IBOutlet weak var choicePlantButton: UIButton!
    var expTool:String!
    var expGrowPlant:String!
    var choicePlant:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setMainTextLabel()
        setRoundButton()
        setExpString()
        // Do any additional setup after loading the view.
    }
    func setRoundButton(){
        growingPlantButton.layer.cornerRadius = growingPlantButton.frame.height / 2
        growingPlantButton.clipsToBounds = true
        growingPlantButton.layer.borderWidth = 1
        growingPlantButton.layer.borderColor = UIColor.white.cgColor
        ToolButton.layer.cornerRadius = ToolButton.frame.height / 2
        ToolButton.clipsToBounds = true
        ToolButton.layer.borderWidth = 1
        ToolButton.layer.borderColor = UIColor.white.cgColor
        choicePlantButton.layer.cornerRadius = choicePlantButton.frame.height / 2
        choicePlantButton.clipsToBounds = true
        choicePlantButton.layer.borderWidth = 1
        choicePlantButton.layer.borderColor = UIColor.white.cgColor
        
    }
    func setScrollView(){
        scrollView.contentSize.height=1000
    }
    @IBAction func MainButton(_ sender: Any) {
        setMainTextLabel()
    }
    @IBAction func GrowingPlantAct(_ sender: Any) {
        expLabel.text = expGrowPlant
    }
    @IBAction func ToolAct(_ sender: Any) {
        expLabel.text = expTool
    }
    @IBAction func choiceAct(_ sender: Any) {
        expLabel.text = choicePlant
    }
    func setMainTextLabel(){
        expLabel.text = "I. 원예테라피를 시작하기 전에 알아둘 일\n\n\n1. 원예테라피 대상자의 상태 파악\n2. 동기 부여\n 매슬로우의 이론 : 인간의 욕구는 낮은 수준의 욕구에서 높은 수준의 욕구로 단계적 순서로 발달한다. 욕구단계를 만족시키면 원예를 위한 동기부여가 가능해지게 된다.\n3. 활동 목표의 설정\n - 원예테라피의 목적은 삶의 질(QOL)과 일상생활 동작(ADL)의 유지, 향상\n4. 원예테라피를 돕는 사람들- 가족, 의사, 간호사, 작업치료사, 물리치료사, 개호복지사, 자원봉사자 등\n\nII. 원예테라피가 가능한 장소\n1. 활동 장소의 넓이\n - 넓이에 따라서 활동 인원 수, 활동 내용, 필요한 원예테라피사의 숫자도 자연히 정해진다. 몇 번 활동하면서 무리 없는 넓이, 인원수를 알아두는 것이 중요하다.\n2. 실외- 뜰 : 볕이 드는 정도에 따라서 거기에 맞는 식물을 배치한다.\n - 밭 : 너무 넓은 곳에서는 통로에 널빤지를 깔아 보행 및 휠체어의 통행을 쉽게 한다.\n - 화단 : 작업성, 보기 쉬움, 배수성, 볕드는 정도를 고려하여 만든다.\n - 옥상 : 수도의 유무가 가장 중요하다.\n - 베란다\n - 화분이나 재배용기는 바퀴가 달린 대 위에 얹는다\n - 바퀴가 달린 대를 사용하면 베란다에 나가지 않아도 작업할 수 있다.\n - 통로 : 평탄하고 단차나 도랑이 없고 배수가 좋으며 잘 미끄러지지 않아야 한다.\n3. 실내\n - 밝기, 토양의 지참, 토양먼지의 여부, 물 사정, 배수의 유무에 따라 재배 관리할 식물의 종류와 작업 내용이 정해지게 된다.  \n4. 온실, 비닐하우스\n - 온실은 비 걱정이 없고 온난한 환경조건을 유지하므로 실내와 같다.\n - 비닐하우스는 보온 효과가 있으며, 육묘 등의 활동이 매우 수월하다.\n5. 접근 통로의 용이성\n - 원예에 있어서 장벽을 없애는 것은 매우 중요하다.\n6. 작업/보행 장소의 확보"
        
     
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setExpString(){
        expTool = "원예에 필요한 도구\n\n\n 1. 필수품 : 물주전자, 물뿌리개, 호스, 노즐, 모종삽, 핀셋, 전정가위, 플라스틱 물통, 빗자루, 쓰레받기\n2. 필요에 따라 갖춰야 하는 것 : 육묘상자, 비닐 포트, 플라스틱 화분, 종이분, 초벌구이 회분, 유약분, 받침대, 퀵 타이, 오이 네트, 사각 삽, 일반 삽, 쇠스랑, 괭이, 낫, 갈퀴, 플라스틱 키, 플라스틱 상자, 비닐 시트, 나무 조각, 나무 자, 막대기, 직각 자, 멀칭 비닐, 잡초 방제 시트, 고정 쇠, 자동 관수 타이머, 차광막, 비닐 터널, 폴대, 전정톱, 고지가위, 풀 깎기 가위, 호스 릴, 목장갑, 얇은 장갑, 농약 분무기, 마스크, 장갑, 보안경, 방제 옷, 농약용 물통, 막대, 라벨, 온도계, 바크 배양토, 선반, 농약 보관함, 일륜차, 리어카\n 3. 도구의 개발- 각자의 상황과 필요에 맞는 도구를 쓴다"
        expGrowPlant = "식물 생육에 필요한 것 알기\n\n\n1. 빛\n - 빛이 식물에 영향을 미치는 것은 빛의 밝기와 일조시간 \n - 각 밝기에 맞는 식물들이 있다. \n - 일조시간 : 적어도 3~4시간 동안 충분하게 햇빛을 받아야 한다.\n 2. 온도\n - 식물에 있어 온도는 발아, 호흡, 광합성, 증산 등에 영향을 미친다.\n - 식물에 따라서 발아에 적당한 온도를 유지시켜 주어야 한다. 종자를 구입하게 되면 겉봉의 설명서를 잘 읽고 파종 시기를 정해야 한다.\n3. 물\n - 물주기를 할 때는 일반적으로 꽃에 닿지 않도록 그리고 토양이 패이거나 튀지 않도록 수압을 일정하게 하여 준다.\n - 물을 주기에 적합한 시간대가 계절마다 다르다.\n 4. 공기·통풍\n- 적당한 통풍은 이산화탄소의 흡수를 잘 하게 하여 광합성을 촉진시킨다.\n 5. 토양- 기르는 식물에 따라서 용토의 종류와 배합이 다르다.- 종류 : 적토, 적옥토, 부엽토, 피트모스, 버미큘라이트, 펄라이트, 경석, 물이끼, 수피계 용토, 전나무 껍질 훈탄 등\n6. 비료\n - 유기비료와 무기비료로 나뉨\n - 효과적인 비료 사용법 : 밑에 있는 잎을 본다, 위에 있는 잎을 본다, 꽃 붙임을 본다, 전체를 본다.\n7. 병해충 방제\n - 생육환경을 조성하여 병해충을 막는다 \n - 영양조건을 조절하여 병해충을 막는다 \n - 적기에 재배한다  - 연작하지 않는다 \n - 단일재배를 하지 않는다 \n - 자재로 병해충을 막는다 \n - 병해충을 들여놓거나 증식시키지 않는다 \n - 병해충을 효과 있게 막는 식물을 주위에 심는다\n - 농약을 사용할 경우 주의사항을 숙지해야 한다.\n8. 잡초 방제\n - 잡초 씨가 있는 토양을 넣지 않는다\n- 잡초 씨를 흘리지 않는다\n - 자재를 이용한다 : 짚 깔기, 인테리어 바크, 수피계 배양토 이용, 시트 이용"
        choicePlant = "식물의 선택\n\n1. 생활주기에 따른 식물 선택\n - 봄심기 1년초 : 매리골드, 맨드라미, 샐비어, 백일홍\n - 가을심기 1년초 : 팬지, 비올라, 스위트 알리섬, 데이지, 금어초\n - 숙근초 : 국화, 블루 샐비어, 저먼 아이리스\n - 다년초 : 카네이션, 채송화, 크리스마스 선인장\n - 봄심기 구근 : 글라디올러스, 달리아, 칼라, 진저\n - 가을심기 구근 : 튤립, 히아신스, 크로커스, 무스카리, 수선화, 아네모네\n 2. 밝기에 따른 식물 선택\n - 거의 일광이 없는 실내 : 관엽식물 가운데 형광등 아래서도 생육이 가능한 식물들, 싹채소 식물  - 권장 : 피커스 퓨밀라- 창가 레이스 커튼 너머로 빛이 드는 실내 : 난 종류, 분화(盆花), 그늘에 강한 허브, 약간의 그늘에 강한 관엽식물  \n - 권장 ; 세인트폴리아, 스파티필럼, 호야, 아디안텀, 파피오페딜럼\n - 창가에서 제법 빛이 들어오는 실내 : 난 종류, 분화류, 삼림 선인장, 채소, 허브, 빛을 좋아하는 관엽식물  \n - 권장 : 호접란, 신비디움, 덴드로비움, 카틀레야\n - 북향의 밝은 실내 : 임파첸스, 베고니아 셈파플로렌스, 오리엔탈 하이브리드, 리코리스, 스테른벨기아\n - 1일 수 시간 볕이 드는 실외 : 미니 채소, 엽채류, 허브, 내음성이 강한 과수\n - 충분히 볕이 드는 실외 : 과수\n3. 채소 및 식용 꽃 : 래디시, 미니 토마토, 미니 캐럿, 시금치, 유채, 청경채, 오크라, 고구마, 사계절 딸기, 표고버섯, 식용 꽃\n4. 촉감이 좋은 식물 : 세덤, 페페로미아 카페라타, 풍지초, 틸란드시아, 헬리크리섬 실버, 백묘국, 강아지풀, 밤나무잎, 안스리움, 아이슬란드 포피, 아스파라거스 마코와니, 베고니아 렉스\n5. 허브의 선택\n - 신변에서 즐기는 허브 : 세이지, 타임, 나스터치움, 바질, 민트류, 레몬 밤 허브, 라벤더\n - 주의해야 할 허브 : 쓴쑥, 탄지, 호스 래디시, 크레손, 페니 로얄, 페퍼민트, 로즈마리, 세이지, 타밍, 금작화, 차이니즐허브, 안젤리카\n6. 물주기를 거의 하지 않는 식물 : 틸란드시아, 다육식물, 콜치컴·크로커스의 구근\n7. 생육이 빨라 결과를 금방 알 수 있는 식물 : 새싹채소, 래디시, 아마릴리스의 포트, 로케트, 프렌치 매리골드, 임파첸스, 민트류, 바질, 포토스, 브라이달 베일, 세인트폴리아\n8. 건화용 식물 : 니겔라(흑종초), 천일홍 등\n9. 공예용 식물 : 으름덩굴, 멀꿀, 키위, 포도, 버드나무, 노송나무, 침엽수류, 호랑가시나무, 소나무, 메밀잣밤나무, 떡갈나무, 상수리나무\n10. 꽃꽂이용 화초 : 스위트피, 패랭이꽃, 아스터(과쫓), 천일홍, 수레국화\n11. 가시가 있는 식물 : 장미, 풍접초, 보리지 등\n12. 독성 식물 :바곳, 은방울꽃, 콜치컴, 디기탈리스 등"
    }
}
