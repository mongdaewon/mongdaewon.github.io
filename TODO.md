# TODO

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
  - [ ] AudioJoin·LazyWindow는 미출시라 스토어 근거 없음. 출시 후 같은 방식으로 보강
  - [ ] RecNow 권한 안내(화면 녹화·마이크·알림) 별도 섹션 검토 — 권한 창 뜰 때 실제로 검색되는 내용
  - [ ] Deep Breath "4-7-8 호흡이 뭔가" 설명 문단 검토 — 검색어가 붙는 자리
- [ ] 4. `/index-request`로 새 URL 색인 요청, 이후 GSC로 검색어 확인

보류: 블로그 섹션. 앱에 묶이지 않는 문제 중심 글을 쓸 때 만든다.

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
- [ ] my-wiki `wiki/mobile/landing-site.md` 등록 현황 갱신 (RecNow·확장 4종·Jumpbar)
- [x] Jumpbar 심사 통과 후 `data/apps.toml`의 `comingsoon` → 실제 App Store 링크로 교체 (2026-09-15 출시, id6804220240)
- [ ] 영문 데모 GIF 중간에 구글 스피너만 도는 0.7초 - 거슬리면 그 구간만 더 당길 것 (보류: 4초 중 0.7초라 흐름은 읽힘)

---

## 20260821.1
- [x] RecNow 앱 페이지 등록 + Google Play 출시 링크 연결 (총 6개 앱)
- [x] JoinCut 여러 영상 합치기 기능 반영 + 처리방침 보강
- [x] iTool Mouser 크롬 확장 처리방침 페이지 작성
- [x] iTool Mouser 크롬 확장 Tools 목록 등록 (확장 4개)
- [x] CLAUDE.md 갱신 (앱 6개, 확장 4개, robots.txt·서치콘솔 인증 파일 명시)
- [ ] my-wiki `wiki/mobile/landing-site.md` 등록 현황 갱신 (RecNow·확장 4종)

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
