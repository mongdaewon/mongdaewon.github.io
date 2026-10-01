# TODO

- [ ] **영문 블로그 4주 성과 (2026-10-22 이후)** — 2026-09-24 첫 3편 발행. GA4 properties/554013286에서
      글별 페이지뷰와 `cta_click`(store_ios·store_android) 전환. 숫자가 안 붙는 글은 제목 키워드부터 다시 본다.

## 20260929.1 커스텀 도메인 mongdaewon.com 전환 (2026-10-01 전환 완료)

목표: 사이트를 `https://mongdaewon.com/`으로 옮기되, 이미 출시된 앱들의 처리방침·웹사이트 링크가 끊기지 않게 한다.
현황: 2026-10-01 전환 완료. 도메인은 Cloudflare Registrar(만료 2027-09-29, 자동 갱신 ON, zone `cdd71e4a4f1dedc02e23fa66d052382e`).
남은 것은 검색·분석 쪽 이전(6번)과 스토어 메타데이터 교체(8번)다.

- [x] 1. 자동 갱신 ON 확인(2026-10-01). 첫 시도는 만료 30일 전이고 **결제 실패로 안 될 수 있다** —
      2027-08 말에 갱신됐는지 눈으로 확인한다. 만료 뒤에도 30일 Redemption Grace Period 가 있다.
- [x] 2. DNS 레코드 9개 생성 (A 4 + AAAA 4 + CNAME www, 전부 DNS 전용). 권한은 **DNS 전용 토큰을 따로 만들어**
      `CLOUDFLARE_DNS_TOKEN` 으로 뒀다 — 기존 `CLOUDFLARE_API_TOKEN`(Workers 용, 계정 전체 범위)에 DNS 를 얹으면
      계정 단위 권한과 존 단위 권한이 한 정책에 섞여 저장 자체가 거부된다(`Failed common permission check`).
      존 범위 토큰은 `/user/tokens/verify` 가 1000 Invalid 를 주는 게 정상이다 — 판정은 zone 엔드포인트로 한다.
- [ ] 3. (권장) GitHub Settings → Pages → Verified domains 에 mongdaewon.com 인증 — TXT 하나. 도메인 탈취 방지
- [x] 4. Pages 커스텀 도메인 설정 → `chore/custom-domain` 머지·push → 배포 성공
- [x] 5. 인증서 승인·Enforce HTTPS ON. 실측 완료: `.com` 200, `www` → apex 301, `github.io` → `.com` 301,
      앱 처리방침 9개(joincut·ivy-todo·deep-breath·widpass·whereismycursor·recnow·jumpbar·audiojoin·itool-mouser) 전부 최종 200
- [ ] 6. 검색·분석 이전
      - [x] Search Console **도메인 속성** `sc-domain:mongdaewon.com` 생성(DNS TXT 인증 완료)
      - [x] 서비스 계정 `examine@dround.iam.gserviceaccount.com` 소유자로 추가 — 조회 통과 확인
      - [x] `tools/analytics/gsc-sites.json` 에 `mongdaewon.com`·`www.mongdaewon.com` → `sc-domain:mongdaewon.com` 매핑
      - [x] 사이트맵 `sitemap.xml` 제출(2026-10-02). 처음엔 "읽을 수 없음"이었는데 서버는 정상(200·application/xml·
            Googlebot UA 200)이었고 URL 검사 실시간 테스트도 통과 — 인증서 발급 전 창에 긁힌 옛 기록이다.
            **삭제·재제출하지 말 것.** 다음 크롤에 "성공"으로 바뀌는지만 본다
      - [ ] 며칠 뒤 Sitemaps 상태가 "성공"·발견된 페이지 64(en 41 + ko 23)로 바뀌었는지 확인
      - [x] 옛 속성에서 주소 변경 제출(2026-10-02, 유효성 검사 전부 통과). **180일간 신호 이전 — 옛 속성 삭제 금지**
      - [ ] GA4 웹 스트림 URL 을 새 도메인으로 — 수집에는 영향 없는 표시용 설정이다. 관리 → 데이터 스트림에서 직접
- [ ] 7. **광고 앱 app-ads.txt 확인** — 전환 직후 실측한다. 미리 7개를 뒤집지 않는다.
      2026-10-01 AdMob 문서 확인 결과 **리디렉트는 허용된다** — "Your web server may redirect the crawler to an
      app-ads.txt file hosted elsewhere" 이고 허용 예시에 다른 도메인(`https://www.cdn.files.example.com/app-ads.txt`)도 있다.
      즉 `github.io/app-ads.txt` → 301 → `.com/app-ads.txt` 한 홉은 정상 동작이어야 한다.
      (이전에 "크롤러가 off-domain 리디렉트를 안 따라간다"고 적어 뒀던 것은 근거가 과했다. IAB 원문 PDF 는 못 받았고,
      크롤링 주체가 AdMob 이라 AdMob 문서를 실효 기준으로 본다.)
      - [x] 한 홉 확인(2026-10-01): `301 location: https://mongdaewon.com/app-ads.txt` → `200`
      - [x] `.com/app-ads.txt` 내용 정상 출력 확인
      - [ ] 며칠 뒤 AdMob → 앱 → app-ads.txt 상태가 "확인됨"인지. **이게 최종 판정이다** — 문서가 아니라 크롤러가 정답이다
      - [ ] 깨졌을 때만 스토어 웹사이트 URL 교체: Android Deep Breath·Ivy To Do·Sulsul(Play 스토어 설정, 심사 없이 즉시),
            iOS Deep Breath·Headly·Ivy To Do·Nanali(ASC 마케팅/지원 URL, 다음 릴리즈에 묶인다)
      실패해도 앱은 멀쩡하다 — 앱은 이 파일을 읽지 않는다. 증상은 입찰 감소에 따른 수익 하락뿐이고 되돌리면 복구된다.
- [ ] 8. 나머지 스토어의 처리방침·웹사이트 URL은 리디렉트로 동작하므로 급하지 않다 — 각 앱 다음 업데이트 때 새 도메인으로.
      앱 코드에 박힌 URL(예: android-audiojoin `AppInfo.PRIVACY`)도 그때 같이
- [ ] 9. (선택) Cloudflare Email Routing으로 `support@mongdaewon.com` → mongdaewon@naver.com, 스토어 연락처 교체

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

---

## 20260914.1 영문 사용법 콘텐츠로 앱 설치 늘리기

목표: 앱별 영문 how-to 페이지를 늘려 롱테일 검색 유입 → 스토어 배지로 전환.
현황: GSC 등록·사이트맵 제출 완료, 28일 노출 16·클릭 0. GA4 미설치.

- [x] 1. GA4 속성 생성 + gtag 설치 + 전환 클릭 이벤트(`cta_click`) + examine 일일 리포트 연결
  - [x] 사용자: GA4 웹 스트림 생성 (`G-TKWBWE14J8`, `properties/554013286`)
  - [x] 서비스 계정 접근 — 계정 단위 권한이 이미 있어 추가 작업 불필요
  - [x] `baseof.html`에 gtag 삽입 (`hugo.IsProduction` 조건으로 로컬 제외)
  - [x] `~/.agents/skills/analytics/SKILL.md` GA4 표에 속성 추가
- [x] 2. how-to를 고아 페이지에서 구출 — 앱 상세 혜택 아래 진입 카드(A2안) + how-to 상·하단 스토어 배지
- [x] 3. 기본 how-to 8개 앱 ko/en 생성 (앱 설명에 적힌 사실만으로 구성 — 내용 보강 예정)
- [x] 3-1. 스토어 등록 정보 기준으로 how-to 보강 — Jumpbar·JoinCut·Ivy To Do·Deep Breath·WidPass·Where Is My Cursor·RecNow (7개)
  - 근거 수집: iOS는 `itunes.apple.com/lookup?id=<id>&country=<kr|us>`, Android는 Play 상세 페이지의 `data-g-id="description"`.
    한 번에 여러 개를 연속 호출하면 iTunes가 막는다 — 앱마다 따로 호출할 것.
  - [ ] AudioJoin 출시(2026-09-24, id6809171081)로 스토어 근거가 생겼다 — how-to 를 등록 정보 기준으로 보강. LazyWindow 는 여전히 미출시
  - [ ] RecNow 권한 안내(화면 녹화·마이크·알림) 별도 섹션 검토 — 권한 창 뜰 때 실제로 검색되는 내용
  - [ ] Deep Breath "4-7-8 호흡이 뭔가" 설명 문단 검토 — 검색어가 붙는 자리
- [ ] 4. `/index-request`로 새 URL 색인 요청(how-to + 블로그 3편), 이후 GSC로 검색어 확인

- [x] 5. 영어 블로그 `/blog/` 개설 + 첫 3편 발행 (JoinCut 무손실 합치기·MKV 불러오기, Ivy To Do 아이비 리 방법)
      구조·front matter·근거 규칙은 AGENTS `### 블로그`. 키워드는 구글 자동완성에서 뽑았다.
- [ ] 6. 블로그 다음 글 — 소재는 문의로 들어온 요청과 개선 릴리즈다. 발행 전 앱 레포(`app-listing.md`)와
      대조하고, 낡은 how-to 를 발견하면 같이 고친다.

---

## 20260825.1
- [x] 갤러리 목록을 한 줄(44px)로 슬림화 - 설명 제거, 키워드 노출, 호스트를 사이트 링크로
- [x] 기본 키워드와 겹치던 5개 제거 (나무위키·한국어 위키백과·DuckDuckGo·GitHub·Google Maps)
- [x] 갤러리 사이트 25 → 66개 (한국 35 · 해외 31), 주소 전부 실측 검증
- [x] 앱과 같은 3x3 아이콘 (갤러리 제목 + 앱 상세 링크, `partials/galleryicon.html`)
- [x] UI 감사 지적 8건 수정 (칩/버튼 혼동, 안 보이는 테두리 4곳, h1~h3 토큰화, 호스트 잘림)
- [x] 갤러리 하단을 PR 요청 → 문의 메일로 교체 + 무료 한도(직접 추가 1개) 안내
- [x] Jumpbar 동작 데모 GIF (ko/en, 4.0초, 언어별 `demo-<lang>.gif`)
- [x] 영문 예시 `yt swiftui` → `yt coffee` (앱 온보딩과 결이 맞게)
- [x] CLAUDE.md 갱신 (앱 7개, 갤러리 규약, 데모 GIF 규약, 레이아웃 트리)
- [x] Jumpbar 심사 통과 후 `data/apps.toml`의 `comingsoon` → 실제 App Store 링크로 교체 (2026-09-15 출시, id6804220240)
- [ ] 영문 데모 GIF 중간에 구글 스피너만 도는 0.7초 - 거슬리면 그 구간만 더 당길 것 (보류: 4초 중 0.7초라 흐름은 읽힘)

---

## 20260821.1
- [x] RecNow 앱 페이지 등록 + Google Play 출시 링크 연결 (총 6개 앱)
- [x] JoinCut 여러 영상 합치기 기능 반영 + 처리방침 보강
- [x] iTool Mouser 크롬 확장 처리방침 페이지 작성
- [x] iTool Mouser 크롬 확장 Tools 목록 등록 (확장 4개)
- [x] CLAUDE.md 갱신 (앱 6개, 확장 4개, robots.txt·서치콘솔 인증 파일 명시)

---

## 20260703.1
- [x] Blowfish 테마 제거 → pico.css 기반 커스텀 layouts 재설계 (기존 URL 경로 유지)
- [x] 앱 리스트 UI(실물 아이콘 + 공식 스토어 배지), 테마 토글, data/apps.toml 단일 출처
- [x] 앱 상세 혜택 중심 재구성(이름→킬링멘트→3줄 혜택→다운로드), 카드 제거
- [x] 모바일 배지 가로 한 줄 정렬, 배지 크기·여백·테두리 정리(라운드/보더 CSS화)
- [x] 스토어 링크 글로벌 형태로 정리, ko 페이지 처리방침 링크 노출
- [x] JoinCut·Where Is My Cursor 등록(총 5개 앱)
- [x] CLAUDE.md 전면 갱신 + 배지 순서(애플→안드로이드) 규칙 명시
- [x] 파비콘 적용(favicon.io 패키지 + head 링크 + webmanifest)
- [x] 헤더 로고 사각형 제거, 브랜드·언어 스위처 소문자화(mongdaewon, en/ko)
- [x] 홈 Apps 아래 Tools 섹션 추가(itool.co.kr + 크롬 확장 3개), data/tools.toml 단일 출처
- [x] 크롬 확장 공식 Chrome Web Store 배지(라이트/다크 테마 스왑)

---

## 20260515.1
- [x] WidPass 앱 페이지 등록 (랜딩 + 개인정보처리방침)
- [x] CLAUDE.md 콘텐츠 구조 갱신 (ivy-todo, widpass 추가)
