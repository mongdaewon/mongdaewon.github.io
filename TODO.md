# TODO

## 다음에 할 일
- [ ] **블로그 4주 성과 (2026-10-22 이후)** — GA4 `properties/554013286`. 글별 페이지뷰, 설치 클릭 `cta_click`(`store_*`),
      블로그 유입은 `nav_blog` + `home_blog`(2026-10-02 부터 둘로 나뉨). 숫자가 안 붙는 글은 제목 키워드부터 다시 본다.
- [ ] `hugo.toml` 에 `timeZone = "Asia/Seoul"` — **다음 글 올리기 전에.** 없으면 오전 9시 전에 push 한 당일 날짜 글이
      UTC 로 미래 글이 되어 조용히 빠진다.
- [ ] 블로그 다음 글 — 소재는 문의로 들어온 요청과 개선 릴리즈. 근거 규칙은 AGENTS 블로그 절.
- [ ] `/index-request` 로 새 도메인 URL 색인 요청(how-to + 블로그) → 이후 GSC 로 검색어 확인

## 도메인 전환 후속 (mongdaewon.com, 2026-10-01)
- [ ] 며칠 뒤: GSC Sitemaps 가 "성공"·발견 64(en 41 + ko 23)인지. 처음 "읽을 수 없음"은 인증서 발급 전에 긁힌 기록이고
      URL 검사 실시간 테스트는 통과했다 — 삭제·재제출하지 말고 다음 크롤을 기다린다.
- [ ] 며칠 뒤: AdMob → 앱 → app-ads.txt 가 "확인됨"인지(옛 주소 → 301 → `.com/app-ads.txt` 한 홉은 확인됨).
      깨졌을 때만 광고 앱의 스토어 웹사이트 URL 을 바꾼다 — Android Deep Breath·Ivy To Do·Sulsul(Play 스토어 설정, 즉시),
      iOS Deep Breath·Headly·Ivy To Do·Nanali(ASC 마케팅/지원 URL, 다음 릴리즈). 깨져도 앱은 멀쩡하고 입찰 감소로 수익만 준다.
- [ ] GA4 웹 스트림 URL 을 새 도메인으로(표시용, 수집 영향 없음) — 관리 → 데이터 스트림
- [ ] (권장) GitHub Settings → Pages → Verified domains 에 mongdaewon.com 인증(TXT 하나) — 도메인 탈취 방지
- [ ] 각 앱 다음 업데이트 때: 스토어의 처리방침·웹사이트 URL 을 `.com` 으로, 지원 이메일을 `support@mongdaewon.com` 으로,
      앱 코드에 박힌 URL(예: android-audiojoin `AppInfo.PRIVACY`)도 같이. 옛 것도 리디렉트·전달로 동작하니 급하지 않다.
- [ ] 2027-04 이후: 옛 `https://mongdaewon.github.io/` GSC 속성 정리 가능(주소 변경 180일). **그 전엔 지우지 않는다.**
- [ ] 2027-08 말: 도메인 자동 갱신이 실제로 됐는지 확인(만료 2027-09-29, 결제 실패면 갱신이 안 된다).

## 사이트 정리 (리디자인 리뷰에서 범위 밖으로 둔 것)
- [ ] 코드 하이라이트 CSS 없음(`markup.toml` `noClasses = false`) — 개발 글에 코드 블록을 넣기 전에 `noClasses = true`
- [ ] baseURL 정본 이중화 — 워크플로 `--baseURL`(Pages 설정)이 `hugo.toml` 을 덮는다. 하나로 정한다
- [ ] 배포 워크플로: 안 쓰는 `fetch-depth: 0` 제거, Hugo 다운로드 `curl` 에 `-f`
- [ ] 블로그 앱별 필터 — 글이 10편쯤 되면. 필터 맨 위에 그 앱의 사용법 링크를 고정한다
      (사용법은 블로그로 옮기지 않기로 했다: 영·한 둘이고 릴리즈마다 고쳐 쓰는 문서라서)
- [ ] (보류) Jumpbar 영문 데모 GIF 중간의 구글 스피너 0.7초 — 4초 중 0.7초라 흐름은 읽힌다. 거슬리면 그 구간만 당긴다

## 사용법(how-to) 보강
- [ ] AudioJoin how-to 를 스토어 등록 정보 기준으로 — 앱 레포 `app-listing.md` 가 정본. 스토어에서 직접 받을 땐
      iOS `itunes.apple.com/lookup?id=<id>&country=<kr|us>`(연속 호출하면 막히니 앱마다 따로). LazyWindow 는 미출시
- [ ] RecNow 권한 안내(화면 녹화·마이크·알림) 섹션, Deep Breath "4-7-8 호흡이 뭔가" 문단 — 검색어가 붙는 자리라 검토

---

## 20260915.1 Jumpbar 갤러리 확장 (66 → 111)

목표: Jumpbar 출시에 맞춰 갤러리를 채운다. 근거는 네이버 월 검색량(사이트명 = 내비게이션 수요)
+ 기존 목록의 카테고리 공백. 주소는 전부 실측 검증한 것만 넣는다.

- [x] 1. 갤러리 45개 추가 — 한국 24 · 글로벌 21 (`data/jumpbar-gallery.toml`) → 111개
- [x] 2. 앱 기본 키워드 `ch` 를 `yh` 로 옮긴다 (`ios-jumpbar`: `Shared/Presets.swift`, `Tests/PresetsTests.swift`)
      — `chore/move-chiebukuro-keyword` d66bd02, 테스트 71개 통과. **아직 배포 전이다.**
      — `ch` 를 ChatGPT(월 1,557만)에 내주기 위한 교환. 출시 당일이라 일본어 사용자가 사실상 없어 지금이 최저 비용.
      `disabled` 가 키워드 문자열로 저장되므로(`Shared/Keywords.swift:97`) 知恵袋를 꺼둔 사용자는 다시 켜진다.
- [ ] 3. 앱 버전 올려 심사 제출 → 배포 확인. **배포 전에 갤러리를 main 에 머지하지 말 것**
      (ChatGPT 행이 먼저 나가면 일본어 기기에서 `ch` 가 두 번 뜬다)
- [x] 4. `cl` Claude · `am` Google AI 모드 추가 — 사용자가 실기기 주소창에서 확인(로그인 상태면 정상 동작).
      딥시크는 같은 방식으로 확인했을 때 입력창이 비어 있어(질문 유실) 제외를 유지한다.
- [ ] 5. 봇 차단으로 검증 못 한 후보를 ego-browser 로 재확인 — Etsy · Indeed · Tripadvisor · Booking.com ·
      Yelp · Britannica · Discogs · BoardGameGeek · Swift Package Index · CoinGecko · Investopedia ·
      Mayo Clinic · Pixabay · Flaticon · Dribbble · Stack Exchange · Internet Archive · Maven Central

검증 실패로 제외(검색량은 컸음): 제미나이 698만·네이버증권 415만·홈택스 262만·스카이스캐너 186만·
엔카 182만·넷플릭스 168만·보배드림 165만·네이버항공권 143만·아고다 106만·치지직 87만·나라장터 70만·
번개장터 66만·여기어때 38만·에이블리 35만·직방 25만·딥시크 1.4만.
사유는 로그인 벽 / 검색 URL 없음 / 파라미터 무시 / 봇 차단 / SPA.
