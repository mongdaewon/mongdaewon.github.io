# TODO

## 다음에 할 일
- [ ] 구독 해지·환불 안내 페이지 `/help/subscription/`
      몽대원 앱 공용(JoinSound 부터 도움말 › 구독 해지 · 환불 › 자세히 보기가 이 주소를 연다, ios-joinsound `AppInfo.cancelHelpURL`). **JoinSound 다음 판 제출 전에 200 이어야 한다.**
      순서: 맨 위 "그 전에, 불편한 점이 있으셨나요?"(의견 메일 support@mongdaewon.com, 하나하나 읽고 고친다) → iPhone·iPad / Android 탭 → 구독 해지(설정 › 내 이름 › 구독) → 환불(reportaproblem.apple.com · Google Play) → 평생권은 해지할 것 없음.
      결제는 스토어가 받아 개발자가 직접 환불 못 한다는 것을 먼저. 영·한(`/ko/help/subscription/` 도), 쓰기 전 `/naver-keyword`. 시안: 2026-11-08 ios-joinsound 세션 1-B.
- [ ] 블로그 다음 글
      소재 근거: GSC 검색어 · 구글 영어 자동완성 · 스토어 리뷰 · 개선 릴리즈 · 지난 글 GA4 성과.
      문의 메일은 뺀다(Gmail 로 안 들어와 볼 수 없고 건수도 적다, 2026-10-31). 근거 규칙은 AGENTS 블로그 절.
- [ ] 영상 소리 추출 글 발행(JoinSound 수정판 뒤)
      `content/blog/extract-audio-from-video-iphone/`, `draft: true`. ios-joinsound TODO "영상 소리 추출 빈틈"이 출시된 뒤 draft 를 빼고 date 를 그날로, 색인 요청.
      👤 그 전에 실기기: 사진 앱 영상 고르기 → Save 까지(시스템 피커·저장은 시뮬레이터 자동화로 못 봤다).
- [ ] Ivy 워치 할 일 컴플리케이션 글
      Ivy 워치 위젯 영어 버그(독일어로 뜸) 수정 버전이 출시된 뒤에 쓴다. 출시되면 영어 위젯 화면부터 찍는다.
      키워드 "to do list apple watch complication". 경쟁 글은 Reddit 질문·각 앱 도움말뿐이고 튜토리얼 글은 없다(2026-10-31).

## 포기하면 안돼 덱 마켓 웹 페이지
구조·규칙은 AGENTS §포기하면 안돼 덱 마켓.
- [ ] 앱 페이지 덱 6개를 인기순으로
      지금은 분류마다 첫 덱(GA4 덱별 공부가 히라가나 3명뿐, 11/2). `card_reviewed`의 `market_deck` 사용자 수가 쌓이면
- [ ] 👤 앱 다음 판 출시 뒤 아이폰에서 덱 페이지 → 앱 열림 확인
      실기기에 출시판 앱이 있어야 한다. 사파리 배너 [열기]와 메시지로 받은 링크 둘 다

## 도메인 전환 후속 (mongdaewon.com, 2026-10-01)
- [ ] 옛 github.io GSC 속성 정리
      2027-04 이후(주소 변경 180일). **그 전엔 지우지 않는다.**
- [ ] 👤 mongdaewon.com 자동 갱신 확인
      2027-08 말. 만료 2027-09-29. 자동 갱신은 켜져 있다(2026-10-20 확인) — 그때는 결제 수단이 살아 있는지만 본다.

## 사이트 정리 (리디자인 리뷰에서 범위 밖으로 둔 것)
- [ ] 블로그 앱별 필터
      글이 10편쯤 되면. 필터 맨 위에 그 앱의 사용법 링크를 고정한다
      (사용법은 블로그로 옮기지 않기로 했다: 영·한 둘이고 릴리즈마다 고쳐 쓰는 문서라서)
- [ ] (보류) Jumpbar 데모 GIF 스피너 0.7초
      영문 데모 GIF 중간의 구글 스피너. 4초 중 0.7초라 흐름은 읽힌다. 거슬리면 그 구간만 당긴다

## Jumpbar 갤러리
- [ ] (보류, 2026-10-20) 봇 차단 후보 ego로 재확인 (2026-09-15 확장 때 남은 것)
      Etsy · Indeed · Tripadvisor · Booking.com ·
      Yelp · Britannica · Discogs · BoardGameGeek · Swift Package Index · CoinGecko · Investopedia ·
      Mayo Clinic · Pixabay · Flaticon · Dribbble · Stack Exchange · Internet Archive · Maven Central
      이미 검증 실패로 뺀 것(다시 시도하지 않는다): 제미나이·네이버증권·홈택스·스카이스캐너·엔카·넷플릭스·보배드림·
      네이버항공권·아고다·치지직·나라장터·번개장터·여기어때·에이블리·직방·딥시크 — 로그인 벽 / 검색 URL 없음 / 파라미터 무시 / 봇 차단 / SPA.
