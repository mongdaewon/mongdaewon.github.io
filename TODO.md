# TODO

## 다음에 할 일
- [ ] 블로그 다음 글
      소재 근거: GSC 검색어 · 구글 영어 자동완성 · 스토어 리뷰 · 개선 릴리즈 · 지난 글 GA4 성과.
      문의 메일은 뺀다(Gmail 로 안 들어와 볼 수 없고 건수도 적다, 2026-10-31). 근거 규칙은 AGENTS 블로그 절.
- [ ] Ivy 워치 할 일 컴플리케이션 글
      Ivy 워치 위젯 영어 버그(독일어로 뜸) 수정 버전이 출시된 뒤에 쓴다. 출시되면 영어 위젯 화면부터 찍는다.
      키워드 "to do list apple watch complication". 경쟁 글은 Reddit 질문·각 앱 도움말뿐이고 튜토리얼 글은 없다(2026-10-31).

## 포기하면 안돼 덱 마켓 웹 페이지 (2026-11-02 시안 2 결정)
목표: 앱 페이지에서 덱을 둘러보고, 누르면 앱의 그 덱 상세가 열린다(앱이 없으면 App Store).
앱은 준비됨(ios-cantquit fb73b9b): `https://mongdaewon.com/(ko/)apps/cantquit/decks/<id>/`를 유니버설 링크로 받아 마켓 덱 상세를 연다.
데이터: `https://cdn.mongdaewon.com/cantquit/catalog.json`(id·title·category·cardCount·cost·hook·description·keyphrase·cover·preview·next).
- [ ] `static/.well-known/apple-app-site-association` (확장자 없음, JSON)
      `{"applinks":{"details":[{"appIDs":["8NFA84AA3R.com.mongdaewon.cantquit","8NFA84AA3R.com.mongdaewon.cantquit.dev"],"components":[{"/":"/apps/cantquit/decks/?*"},{"/":"/ko/apps/cantquit/decks/?*"}]}]}}`
      GitHub Pages가 `.well-known`을 내보내는지·200인지 확인. `/decks/` 목록은 웹에 남고 덱 상세만 앱으로 간다
- [ ] 빌드 때 catalog를 받아 덱 페이지 만들기 (Hugo `resources.GetRemote` 등)
- [ ] 앱 페이지: 덱 마켓 링크 카드(howto-card 모양) + 인기 덱 6개 그리드
- [ ] `/apps/cantquit/decks/`: 분류 칩 + 덱 그리드(표지: cover 그림 또는 keyphrase 글자, 무료/Plus 꼬리표)
- [ ] `/apps/cantquit/decks/<id>/`: 표지·hook·설명·장수/분류/무료·Plus·미리보기 3장·[포기하면 안돼에서 받기]·데스크톱 QR·다음 권
      버튼 href는 같은 덱 페이지 주소가 아니라 App Store(앱이 있으면 유니버설 링크가 먼저 앱을 연다)
- [ ] 👤 앱 다음 판 출시 뒤 아이폰에서 덱 페이지 → 앱 열림 확인

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
