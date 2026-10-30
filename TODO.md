# TODO

## 다음에 할 일
- [ ] 영어 페이지에 한글 앱 이름(술술낱말·척척장기)
      2026-10-22 확인: /apps/·홈 카드와 /apps/chukchuk/ 제목·alt·JSON-LD name 이 한글. `data/apps.toml`에 name_ko 를 따로 두고 영어 페이지는 영어 이름(game-bluedot TODO에서 옮김)
- [ ] 블로그 다음 글
      소재는 문의로 들어온 요청과 개선 릴리즈. 근거 규칙은 AGENTS 블로그 절.
- [ ] 블로그: 아이폰 음성 메모 합치기(JoinSound)
      제목 후보 "How to Merge Voice Memos on iPhone (Into One Recording)". 구글 자동완성(2026-10-30):
      merge voice memos on iphone · into one · together · without app · for free, combine voice memos iphone.
      기존 글(combine-audio-files…, 이어 붙이기 vs 겹치기 비교)과 겹치지 않게 '음성 메모 → 한 파일' 하나만 푼다. `app: joinsound`.
      쓰기 전 확인: 음성 메모 앱 자체에 합치기가 없는지(iOS 26), 공유 → JoinSound 흐름, 무료 2개·M4A 한도(앱 AGENTS 58행).
      화면: shoot.sh 데모 장면 2장 + 홍보 영상(cdn promo) 재사용.

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
