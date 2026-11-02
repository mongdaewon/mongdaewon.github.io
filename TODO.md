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
- [x] `static/.well-known/apple-app-site-association` (확장자 없음, JSON)
      `{"applinks":{"details":[{"appIDs":["8NFA84AA3R.com.mongdaewon.cantquit","8NFA84AA3R.com.mongdaewon.cantquit.dev"],"components":[{"/":"/apps/cantquit/decks/?*"},{"/":"/ko/apps/cantquit/decks/?*"}]}]}}`
      `/decks/` 목록은 웹에 남고 덱 상세만 앱으로 간다. 배포 액션(upload-pages-artifact v3)은 숨김 폴더를 싣는다(.git·.github만 뺀다)
- [ ] 배포 뒤 AASA 200 확인
      `curl -sI https://mongdaewon.com/.well-known/apple-app-site-association`
- [x] 빌드 때 catalog를 받아 덱 페이지 만들기
      `content/apps/cantquit/decks/_content.ko.gotmpl`(content adapter). catalog가 한국어뿐이라 ko에만 만든다
- [ ] 앱 페이지: 덱 마켓 링크 카드(howto-card 모양) + 인기 덱 6개 그리드
- [ ] `/apps/cantquit/decks/`: 분류 칩 + 덱 그리드
      기본판 있음(catalog 순 카드 그리드·무료/Plus). 남은 것: 분류 칩·표지(표지: cover 그림 또는 keyphrase 글자, 무료/Plus 꼬리표)
- [ ] `/apps/cantquit/decks/<id>/`: 표지·hook·설명·장수/분류/무료·Plus·미리보기 3장·[포기하면 안돼에서 받기]·데스크톱 QR·다음 권
      기본판 있음(hook·설명·미리보기 3장·다음 덱·스마트 배너). 남은 것: 표지·데스크톱 QR
      버튼 href는 App Store. 같은 도메인 안에서 누른 링크는 유니버설 링크가 앱을 열지 않는다(밖에서 온 QR·검색 클릭만 앱이 연다)
      그래서 덱 페이지에 `<meta name="apple-itunes-app" content="app-id=6825195851, app-argument=<이 페이지 주소>">` — 사파리 위 배너 [열기]가 앱의 그 덱으로 간다
- [ ] 덱 페이지 글: 덱 내용 소개가 아니라 "이 덱을 받으면 내 영어가 이렇게 는다"가 읽히게(2026-11-02 사용자)
      앱 마켓 문구와 같은 결: catalog `hook`(공부하면 얻는 것·모르면 잃는 것)을 제목 아래 크게, `description`은 그 아래.
      규칙 원본은 ios-cantquit `decks/README.md` §마켓 그리드 문구. 덱마다 "받기 전 → 외운 뒤" 한 줄을 더한다
      (예: 오즈의 마법사 1~4장 "한 쪽에 모르는 단어 20개 → 5개, 사전 없이 1~4장")
      덱 이름은 catalog `title` 그대로(오즈는 2026-11-02 "1권"에서 장 범위로 바꿨다 — 원서 시리즈 권수와 헷갈려서). 쓰기 전에 /naver-keyword로 덱 주제 검색어 확인
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
