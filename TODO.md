# TODO

## 다음에 할 일
- [ ] 블로그 다음 글
      소재는 문의로 들어온 요청과 개선 릴리즈. 근거 규칙은 AGENTS 블로그 절.

## 도메인 전환 후속 (mongdaewon.com, 2026-10-01)
- [ ] 며칠 뒤: AdMob → 앱 → app-ads.txt 가 "확인됨"인지(옛 주소 → 301 → `.com/app-ads.txt` 한 홉은 확인됨).
      깨졌을 때만 광고 앱의 스토어 웹사이트 URL 을 바꾼다 — Android Deep Breath·Ivy To Do·Sulsul(Play 스토어 설정, 즉시),
      iOS Deep Breath·Headly·Ivy To Do·Nanali(ASC 마케팅/지원 URL, 다음 릴리즈). 깨져도 앱은 멀쩡하고 입찰 감소로 수익만 준다.
- [ ] GA4 웹 스트림 URL 새 도메인으로
      표시용, 수집 영향 없음 — 관리 → 데이터 스트림
- [ ] (권장) GitHub Pages 도메인 인증
      Settings → Pages → Verified domains 에 mongdaewon.com 인증(TXT 하나) — 도메인 탈취 방지
- [ ] 앱 업데이트 때 URL·이메일 .com으로
      스토어의 처리방침·웹사이트 URL 을 `.com` 으로, 지원 이메일을 `support@mongdaewon.com` 으로,
      앱 코드에 박힌 URL(예: android-audiojoin `AppInfo.PRIVACY`)도 같이. 옛 것도 리디렉트·전달로 동작하니 급하지 않다.
- [ ] 옛 github.io GSC 속성 정리
      2027-04 이후(주소 변경 180일). **그 전엔 지우지 않는다.**
- [ ] 👤 mongdaewon.com 자동 갱신 확인
      2027-08 말. 만료 2027-09-29, 결제 실패면 갱신이 안 된다. Registrar 결제는 대시보드에서 본다.

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
- [ ] 봇 차단 후보 ego로 재확인 (2026-09-15 확장 때 남은 것)
      Etsy · Indeed · Tripadvisor · Booking.com ·
      Yelp · Britannica · Discogs · BoardGameGeek · Swift Package Index · CoinGecko · Investopedia ·
      Mayo Clinic · Pixabay · Flaticon · Dribbble · Stack Exchange · Internet Archive · Maven Central
      이미 검증 실패로 뺀 것(다시 시도하지 않는다): 제미나이·네이버증권·홈택스·스카이스캐너·엔카·넷플릭스·보배드림·
      네이버항공권·아고다·치지직·나라장터·번개장터·여기어때·에이블리·직방·딥시크 — 로그인 벽 / 검색 URL 없음 / 파라미터 무시 / 봇 차단 / SPA.
