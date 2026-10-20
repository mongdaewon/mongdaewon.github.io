# TODO

## 다음에 할 일
- [ ] 블로그 다음 글
      소재는 문의로 들어온 요청과 개선 릴리즈. 근거 규칙은 AGENTS 블로그 절.

## 도메인 전환 후속 (mongdaewon.com, 2026-10-01)
- [ ] 옛 github.io GSC 속성 정리
      2027-04 이후(주소 변경 180일). **그 전엔 지우지 않는다.**
- [ ] 👤 mongdaewon.com 자동 갱신 확인
      2027-08 말. 만료 2027-09-29. 자동 갱신은 켜져 있다(2026-10-20 확인) — 그때는 결제 수단이 살아 있는지만 본다.

## 사이트 정리 (리디자인 리뷰에서 범위 밖으로 둔 것)
- [ ] 코드 하이라이트 CSS 켜기
      CSS 없음(`markup.toml` `noClasses = false`) — 개발 글에 코드 블록을 넣기 전에 `noClasses = true`
- [ ] baseURL 정본 하나로
      워크플로 `--baseURL`(Pages 설정)이 `hugo.toml` 을 덮는다. 하나로 정한다
- [ ] 배포 워크플로 정리
      안 쓰는 `fetch-depth: 0` 제거, Hugo 다운로드 `curl` 에 `-f`
- [ ] 블로그 앱별 필터
      글이 10편쯤 되면. 필터 맨 위에 그 앱의 사용법 링크를 고정한다
      (사용법은 블로그로 옮기지 않기로 했다: 영·한 둘이고 릴리즈마다 고쳐 쓰는 문서라서)
- [ ] (보류) Jumpbar 데모 GIF 스피너 0.7초
      영문 데모 GIF 중간의 구글 스피너. 4초 중 0.7초라 흐름은 읽힌다. 거슬리면 그 구간만 당긴다

## 사용법(how-to) 보강
- [ ] RecNow 권한·Deep Breath 4-7-8 문단
      RecNow 권한 안내(화면 녹화·마이크·알림) 섹션, Deep Breath "4-7-8 호흡이 뭔가" 문단 — 검색어가 붙는 자리라 검토

## Jumpbar 갤러리
- [ ] (보류, 2026-10-20) 봇 차단 후보 ego로 재확인 (2026-09-15 확장 때 남은 것)
      Etsy · Indeed · Tripadvisor · Booking.com ·
      Yelp · Britannica · Discogs · BoardGameGeek · Swift Package Index · CoinGecko · Investopedia ·
      Mayo Clinic · Pixabay · Flaticon · Dribbble · Stack Exchange · Internet Archive · Maven Central
      이미 검증 실패로 뺀 것(다시 시도하지 않는다): 제미나이·네이버증권·홈택스·스카이스캐너·엔카·넷플릭스·보배드림·
      네이버항공권·아고다·치지직·나라장터·번개장터·여기어때·에이블리·직방·딥시크 — 로그인 벽 / 검색 URL 없음 / 파라미터 무시 / 봇 차단 / SPA.
