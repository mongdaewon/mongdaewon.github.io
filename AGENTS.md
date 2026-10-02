# AGENTS.md

## 작업 운영

- 조회·분석만 하는 작업에는 브랜치가 필요 없다. 파일을 수정할 때는 먼저 `git status`를 확인하고 `feat/<name>`, `fix/<name>`, `chore/<name>`, `docs/<name>` 중 맞는 작업 브랜치를 만든다.
- 작고 명확하며 한 번에 끝낼 수 있는 저위험 변경은 바로 구현한다. 절차를 위한 `TODO.md`는 만들거나 수정하지 않는다.
- 여러 단계이거나 한 번에 끝내기 어렵고 조사·반복 수정이 필요한 작업은 구현 전에 `TODO.md`에 목표와 실행 가능한 체크리스트를 작성하고 진행 중 갱신한다.
- 아키텍처·대규모 리팩터링·보안·데이터 손실·회귀 위험이 있는 중요한 TODO 작업은 검사 후 `AGENTS.md`, `TODO.md`, `git diff`를 기준으로 독립 리뷰를 요청한다. 발견된 문제를 해결한 뒤 `finish-work`로 마무리한다.

This file provides guidance to 개발 에이전트 when working with code in this repository.

## 프로젝트 개요

Mongdaewon 개발사의 Hugo 기반 정적 웹사이트. 모바일·맥 앱 + 웹 도구(itool.co.kr) + 크롬 확장을 소개하는 회사 웹사이트.

- **사이트 URL:** https://mongdaewon.com/ (2026-10-01 전환. 옛 `mongdaewon.github.io` 는 같은 경로로 301 된다 — 레포 이름은 그대로다)
- **Hugo 버전:** 0.163.2 (extended) — GitHub Actions 워크플로에 고정
- **테마:** 없음. 직접 작성한 `layouts/` + 자체 스타일시트 `assets/css/site.css` 하나(프레임워크 없음). Blowfish 에 이어 pico.css 도 2026-10-02 에 걷어냈다(아래 레이아웃 절).

## 주요 명령어

```bash
# 로컬 개발 서버
hugo server

# 프로덕션 빌드
hugo --gc --minify
```

배포는 main 브랜치 push 시 GitHub Actions(`.github/workflows/deploy.yml`)가 자동으로 빌드 및 GitHub Pages에 배포. (서브모듈 없음 — 일반 clone으로 충분)

## 아키텍처

### 다국어 구조

기본 언어는 영어(`en`), 한국어(`ko`)를 추가 지원. `defaultContentLanguageInSubdir = false`이므로 en은 루트(`/`), ko는 `/ko/`. 콘텐츠 파일명 규칙:
- 영어: `_index.md` 또는 `index.md`
- 한국어: `_index.ko.md` 또는 `index.ko.md`

언어별 설정은 `config/_default/languages.*.toml`에서 관리. 헤더의 EN/KO 스위처는 `.AllTranslations`로 생성.

### 콘텐츠 구조

```
content/
├── _index.md / _index.ko.md          # 홈페이지
└── apps/
    ├── _index.md / _index.ko.md      # 앱 목록 페이지
    └── <slug>/                        # 개별 앱 (Hugo branch bundle)
        ├── _index.md / _index.ko.md   # YAML front matter, type: app
        ├── icon.png                   # 실물 앱 아이콘 (256×256)
        └── privacy-policy/
            └── index.md               # 처리방침 (영어 단일)
```

등록 앱 목록은 `data/apps.toml`이 정본이다(여기에 적으면 낡는다).

**앱 상세 페이지 콘텐츠 구조:** 아이콘·이름·1줄 킬링멘트(`params.tagline`)·배지 줄 → 3줄 혜택(본문) → 사용법 카드 → "Posts about X"(그 앱 글이 있을 때만, en) → 하단 받기 → 문의·처리방침. 본문은 기능 나열이 아니라 "사용자가 얻는 혜택" 중심으로 작성.

**동작 데모(선택):** 번들에 `demo-<lang>.gif`(예: `demo-ko.gif`)를 두면 혜택 본문 옆(모바일은 위)에
자동으로 붙는다. **언어가 맞는 파일이 없으면 아무것도 안 나온다** — 한국어 사파리 화면을 영어
페이지에 붙이면 없느니만 못하다. 실기기 화면 기록에서 뽑고, 변환은
`ffmpeg`(palettegen/paletteuse) → `gifsicle -O3 --lossy` 순서. 폭 540px 이면 모바일에서 딱 2배다.
  현재 설정은 `fps=12`·`max_colors=128`·`--lossy=90`, 4초, 언어당 650~800KB.
  ⚠️ **끝에 스크롤이 들어가면 용량이 두 배가 된다** — GIF 은 움직인 픽셀만큼 커진다.
  화면이 멎는 지점에서 끊는다(영문 첫 인코딩이 1.6MB 였던 이유).

**새 앱 추가 시:** 가장 빠른 길은 기존 번들을 통째로 복사하는 것이다 — 모바일 앱은 `content/apps/joincut/`, 맥 단독은 `content/apps/whereismycursor/`.

1. `content/apps/<slug>/_index.md`(+`.ko.md`). front matter는 **YAML**이며 `params.tagline`은 중첩이다:
   ```yaml
   ---
   type: app
   title: "JoinCut - Lossless Video Merge"
   description: "..."
   summary: "..."        # 목록에 뜨는 한 줄
   params:
     tagline: "..."      # 상세 페이지 1줄 킬링멘트
   ---
   ```
   본문은 3줄 혜택. 줄바꿈은 줄 끝 공백 2개(hard break).
2. `content/apps/<slug>/icon.png` (256×256 실물 아이콘) 배치.
3. `data/apps.toml`에 `[[app]]` 항목 추가(slug, name, 스토어 URL 등).
4. `content/apps/<slug>/privacy-policy/index.md` 처리방침 작성(아래 규칙).

**처리방침 섹션 규칙** (실물 5개에서 확립. 영어 단일, `layout: "single"`)

항상 넣는 8개: `Introduction` / `Information We Collect` / `Information We Do NOT Collect` / `Third-Party Services` / `Data Security` / `Children's Privacy` / `Your Rights` / `Changes to This Policy` / `Contact Us`

`Advertising`·`In-App Purchases`는 **있든 없든 넣는다** — 없으면 "does not display any advertisements" 처럼 명시적으로 부정한다(스토어 설문과 대조되는 항목이라 침묵보다 명시가 안전).

앱 기능에 따라 추가:

| 섹션 | 넣는 경우 | 실물 |
|---|---|---|
| `Photo Library Access` | 사진·영상 라이브러리 접근 | joincut |
| `Screen and Audio Recording` | 화면 캡처·마이크 | recnow |
| `Data Storage` · `Local Data` | 로컬·iCloud 저장 | ivy-todo · whereismycursor |

⚠️ **실태와 문구가 어긋나면 스토어 심사에서 걸린다.** Analytics만 쓰면서 crash·성능 수집 문구를 넣지 말 것.
⚠️ **처리방침 URL은 스토어 제출 전에 확보한다.** 페이지 생성 → main push → `https://mongdaewon.com/apps/<slug>/privacy-policy/` 200 확인 순서.

### 블로그 — `content/blog/`

앱 개발 문의를 푼 기록과 앱으로 끌어오는 글을 **영어로만** 발행한다(`.ko.md` 없음).

- 글 하나는 leaf bundle: `content/blog/<slug>/index.md` → `/blog/<slug>/`. 스크린샷은 같은 번들에 둔다.
- front matter는 `title`·`description`·`date` 셋 다 필수다. **`date`가 없으면 빌드가 멈춘다**(`blog/single.html`의 `errorf`) — 두면 목록 맨 끝으로 가고 `Jan 1, 0001`이 찍힌다. `layout`은 지정하지 않는다(섹션 템플릿이 자동).
- 목록의 한 줄 설명은 `description`이고, 없으면 본문 앞부분(`.Summary`)이 대신 들어간다.
- `app: <slug>`(선택)를 넣으면 글 **끝에** 앱 카드(아이콘·이름·한 줄·배지, `appcard.html`)와 "More about X"(같은 앱의 다른 글)가 붙는다. 검색으로 들어온 사람이 답을 다 읽은 자리다. **글의 목적이 설치라면 넣는다.** 글 위에는 앱 줄을 두지 않는다(2026-10-02 A3).
- **`app:` 슬러그가 틀리면 빌드가 멈춘다**(`partials/app.html`의 `errorf`). 예전에는 배지만 조용히 사라졌다.
- 글은 영어 검색 의도에서 출발한다. 제목·소제목은 구글 자동완성에 실제로 나오는 질문을 쓴다(`/naver-keyword`의 구글 자동완성).
- ⚠️ **앱 기능을 적기 전에 앱 레포를 본다.** `content/apps/<slug>/how-to/`만 믿으면 안 된다 — 이 사이트는 앱 릴리즈보다 늦게 갱신되므로 how-to 가 낡아 있을 수 있다(2026-09-24 JoinCut MKV 가 그랬다). 앱 레포의 `app-listing.md`(출시 노트·기능 목록)와 `AGENTS.md`를 대조하고, 어느 쪽에도 없는 사양(코덱·해상도 조건 등)은 지어내지 않는다. 글을 쓰다 how-to 가 낡은 걸 발견하면 how-to 도 같이 고친다.
- 글의 성과는 GA4 에서 본다. 페이지뷰는 `page_location`, 설치로 나가는 클릭은 `cta_click`(`store_ios`·`store_android` + `cta_app`)이라 "어느 글을 읽고 어느 스토어로 갔는지"가 둘의 교차로 나온다.
- 헤더 Blog 탭은 `GetPage "/blog"`로 그린다. ko 사이트에는 블로그 페이지가 없어 탭이 안 뜬다(ko 탭은 앱·도구 둘).
- RSS는 `disableKinds`로 꺼져 있다. 구독을 열려면 블로그 섹션에만 `outputs`를 주고 켠다(전역 해제는 홈·앱 섹션 피드까지 만든다).

### 앱 메타데이터 단일 출처 — `data/apps.toml`

언어 무관 앱 메타(표시 순서, 이름, 스토어 링크, 이모지/색 fallback)는 `data/apps.toml`에서 한 곳으로 관리. 레이아웃이 slug로 매칭해 콘텐츠(제목/요약/본문, 언어별)와 결합.

- 스토어 링크는 **글로벌 형태**로: 애플은 `https://apps.apple.com/app/id{ID}` (country 코드·`mt=` 제거 → Apple이 접속자 지역으로 자동 리다이렉트). Google Play는 지역 파라미터 없이 `?id=...`.
- 필드: `appstore`, `macappstore`, `googleplay`, (선택) `comingsoon`.

### Jumpbar 키워드 갤러리 — `data/jumpbar-gallery.toml`

`/apps/jumpbar/gallery/`(`layouts/_default/gallery.html`). `＋` 를 누르면
`mdjumpbar://add?k=&n=&u=` 로 Jumpbar 앱의 사이트 추가 폼이 채워진다.

- 필드: `keyword`, `name`(+`name_ko`), `url`(검색어 자리는 `{query}`), `locale`(`"ko"` | `"en"`).
  **설명 필드는 없다** — 66줄짜리 목록에 한 줄씩 붙으면 벽이 된다.
- 행은 `키워드 - 이름 - 호스트 - ＋` 한 줄(44px)이고, **호스트는 그 사이트로 나가는 링크**다.
  행에서 테두리·primary 색을 쓰는 건 `＋` 하나뿐이다 — 키워드에도 칩을 두르면 안 눌리는 게 버튼처럼 보인다.
  좁은 화면에서 자리가 모자라면 **호스트가 줄고 이름은 안 줄인다**(이름이 그 행의 정체다).
- **파일 순서가 곧 페이지 순서다.** 카테고리 주석으로 묶어 둔다.
- 키워드는 파일 안에서 유일해야 하고 **앱 기본 키워드(`Shared/Presets.swift`)와도 겹치면 안 된다**
  — 겹치면 한 화면에 같은 사이트가 두 번 뜬다. 지역별 기본(`rk` `kl` `lb` `fk` `ch`)까지 본다.
- 한국 사이트는 한글 초성(자판을 안 바꾸게), 나머지는 영문 2글자.
- ⚠️ **주소는 그 사이트에서 실제로 두 단어를 검색해 확인한다.** curl 이 403·캡차로 막히는 곳
  (Reddit·npm·IMDb·G마켓·오늘의집·올리브영 등)은 **주소가 틀린 게 아니라 자동화를 막는 것**이므로
  브라우저를 띄워 결과 페이지를 보거나, 그 사이트의 검색 폼 `action` 을 읽어 맞춘다.
- `#` 뒤(fragment)에 검색어가 붙는 사이트는 넣지 않는다 — 확장이 넘기지 못한다.

### 웹 도구·크롬 확장 — `data/tools.toml` (홈 "Tools" 섹션)

앱 외 자사 웹 도구·브라우저 확장은 `data/tools.toml`에서 관리하며, 홈의 "Tools" 섹션(`partials/toolslist.html`, 데스크톱은 오른쪽 칸·모바일은 아래)에 노출. 헤더의 Tools 탭은 홈의 `#tools`로 온다(도구 전용 페이지는 없다).

- 필드: `slug`, `name`/`name_ko`, `desc`/`desc_ko`, `url`/`url_ko`, `kind`(`"web"` | `"chrome"`).
- **base 필드는 영어, `_ko` 접미사가 한국어 override**(없으면 base로 fallback). `url_ko`도 동일 — 예: iTool은 en `https://itool.co.kr/en/`, ko `https://itool.co.kr`.
- `kind`는 지금 사이트가 읽지 않는다. 도구 행은 앱 행과 같은 모양이고 행 전체가 새 탭 링크(↗)다. 크롬 웹스토어 배지는 2026-10-02 리디자인에서 뺐다.
- 아이콘: `static/img/tools/<slug>.png`. (앱 아이콘과 동일하게 CSS 테두리로 크기 통일)
- 현재: iTool(web) + 크롬 확장 4개(유튜브 자막 도우미·네이버 블로그 도구·Oh My Table·iTool Mouser).
- **확장 문구는 확장 저장소의 `public/_locales/{en,ko}/messages.json`(`extDesc`)를 그대로 옮긴다.** 여기서 새로 쓰면 스토어 설명과 어긋난다. 아이콘도 확장의 `public/icons/icon128.png`를 복사(128px가 관례).

**크롬 확장의 처리방침**은 `content/apps/<slug>/privacy-policy/index.md`에 둔다(앱과 같은 경로).
`data/apps.toml`에는 **등록하지 않는다** — `applist.html`이 apps.toml을 순회하므로 등록하지 않으면
앱 목록·홈에 뜨지 않고 처리방침 페이지만 생긴다. 확장은 `tools.toml`이 자리이기 때문이다.
`_index.md` 없이 `privacy-policy/`만 두면 되고, Hugo가 leaf bundle로 렌더한다(itool-mouser가 그 예).

확장 처리방침에는 앱에 없는 두 절을 넣는다:
- `Website Access` — `<all_urls>` 같은 광범위 권한이 왜 필요한지, 무엇을 **하지 않는지**
- 외부로 나가는 통신이 있으면 그 절(예: 선택한 글자를 검색엔진으로 보내는 경우)

### ⚠️ 스토어 다운로드 배지 — 순서·정렬 규칙

- **버튼 순서는 홈·앱 목록·앱 상세 등 어디서든 항상 동일하게 애플(App Store) → 안드로이드(Google Play) 순으로 정렬한다.** (Mac App Store는 애플 계열이므로 App Store 다음.) 있는 것만 노출하고 없으면 생략.
- **배지는 설치를 결정하는 자리에만 둔다.** 앱 상세·사용법은 아이콘 줄 우측(모바일은 아이콘 아래 왼쪽 정렬) +
  본문 끝 `.dl-foot`(「받기」 + 배지, `partials/dlfoot.html`), 블로그 글은 끝의 앱 카드(`partials/appcard.html`).
  **홈·앱 목록 행에는 배지를 두지 않는다** — 행마다 검은 배지 두 개면 앱 이름보다 배지가 먼저 보인다(2026-10-02 A3).
  목록 행은 플랫폼을 글자로(iPhone · Mac · Android, 스토어 필드에서만 판단 — iPad 는 apps.toml 이 몰라서 안 쓴다)
  적고 행 전체가 상세로 가는 링크다. 배지를 새로 두는 곳은 `.dl-row`를 쓰고 폭은 `--dl-col`(128px) 한 값이다.
- 이 순서는 `layouts/partials/storebadges.html` **단일 파샬**이 강제한다(렌더 순서: `appstore` → `macappstore` → `googleplay`). 배지를 새로 렌더하는 곳이 생기면 반드시 이 파샬을 재사용할 것 — 순서를 손으로 나열하지 말 것.
- 배지 이미지(`static/img/badges/app-store.png`, `google-play.png`)는 **버튼만 있는 불투명 검은 사각형**(테두리·여백 없음, 동일 크기). 라운드(`border-radius`)·테두리(`border`)·간격(`gap`)은 전부 CSS가 담당하며, 다크모드에서는 테두리를 밝게 처리해 경계를 확보한다.

### 레이아웃 (`layouts/`)

```
assets/css/site.css             # 스타일 전부 (토큰 → 기본 → 구성 요소). baseof 가 minify+fingerprint 로 링크
layouts/
├── _default/baseof.html      # 뼈대(헤더 탭 + 언어/테마, main, 푸터, GA4, 테마 토글 스크립트)
├── _default/single.html      # 처리방침 등 단일 페이지
├── _default/gallery.html     # Jumpbar 키워드 갤러리 (layout: "gallery")
├── _default/howto.html       # 앱 사용법 (content/apps/<slug>/how-to/)
├── blog/list.html            # /blog/ 글 목록
├── blog/single.html          # 블로그 글 (제목+날짜 → 본문 → app: 있으면 앱 카드 + 같은 앱 다른 글)
├── index.html                # 홈 = partials/hub.html
├── apps/list.html            # /apps/ = partials/hub.html (홈의 중복, canonicalHome)
├── app/list.html             # 앱 상세 (type="app" 섹션, 데모 GIF·사용법 카드·이 앱 이야기)
└── partials/
    ├── app.html              # 슬러그 → apps.toml 항목(+ .page). 틀린 슬러그는 errorf 로 빌드 실패
    ├── hub.html              # 홈 본문: h1 한 줄 소개 · 앱 목록 | 최근 글(en) + 도구
    ├── applist.html          # 앱 목록 행 (아이콘·이름·한 줄·플랫폼·›, 배지 없음)
    ├── toolslist.html        # 도구 섹션 (#tools, data/tools.toml)
    ├── postlist.html         # 글 목록 한 벌 (블로그 목록·홈·앱 상세·글 끝 공용)
    ├── dlfoot.html           # 「Get X / X 받기」 + 배지 (앱 상세·사용법 끝)
    ├── appcard.html          # 블로그 글 끝 앱 카드
    ├── storebadges.html      # 스토어 배지 (순서 강제, 위 규칙 참조)
    └── galleryicon.html      # 3x3 아이콘 (갤러리 제목 + 앱 상세 링크 공용)

layouts/robots.txt              # robots + sitemap 위치 (enableRobotsTXT = true)
```

- **CSS는 `assets/css/site.css` 한 파일**이다. 맨 위에 토큰, 그다음 기본 스타일(pico 가 해 주던 리셋·링크·제목·목록·표·코드·포커스), 그 아래 구성 요소. 프레임워크를 다시 들이지 않는다 — pico 기본값이 자체 스케일과 싸워서 생긴 결함(제목 아래 margin collapse, 제목 크기 덮어쓰기, 넓은 화면에서 루트 글자가 21px 까지 커지는 것)이 리디자인의 이유였다.
- **폰트: Pretendard Variable**(jsdelivr, dynamic-subset). `--font` 토큰.
- **타이포는 5단계 토큰만 쓴다** — `--fs-sm`(14) `--fs-base`(16) `--fs-lg`(18) `--fs-xl`(20) `--fs-2xl`(24). 새 `font-size`에 임의값을 쓰지 말 것. 웨이트는 400·700 두 개만. 루트 글자는 **16px 고정**이다(화면 폭 따라 키우지 않는다). 예외는 인라인 `code`(둘러싼 줄의 .875em) 하나.
- **간격은 4px 의 배수**, **radius 는 `--r`(8px) 하나.** 예외는 둘 — 앱 아이콘(크기의 약 22%, iOS 아이콘 관례)과 기기 화면 모양인 데모 GIF(20px).
- **색은 토큰만**(`--bg` `--fg` `--muted` `--accent` `--rule` `--badge-line` …). 라이트·다크는 토큰 블록에서만 갈린다 — `data-theme` 가 이기고 없으면 OS 설정. 다크 블록이 두 번(미디어쿼리용·속성용) 적힌 것은 의도다: `light-dark()`는 iOS 17.5+ 라 미지원 브라우저에서 색이 통째로 사라진다.
- **컨테이너 폭:** 헤더·본문·푸터 모두 70rem. 홈(과 `/apps/`)만 `main.wide`로 두 칸을 쓰고, 나머지 페이지는 그 안에서 46rem 을 **왼쪽 정렬**로 읽는다 — 홈↔상세를 오갈 때 브랜드가 옆으로 튀지 않게. 블로그 글 본문·제목·앱 카드는 42.5rem(18px 에서 한 줄 약 75자).
- 리스트 행은 `--rule` 구분선으로 나눈다. 테마별로 정해 둬서 양쪽 다 ~1.6:1 로 보인다(예전 pico 구분선은 다크에서 ~1.3:1 로 사라졌다).
- `<link rel=canonical>`은 baseof에서 생성. front matter `canonicalHome: true`인 페이지(`content/apps/_index.md*`)는 홈을 가리켜 홈/`/apps/` 중복을 정리한다.
- 테마(라이트/다크) 토글은 헤더에 있으며 `data-theme` + `localStorage`로 유지. 미설정 시 `prefers-color-scheme` 따름.
- 앱 아이콘은 `.app-ico`에 CSS 테두리(`--rule`)로 박스 경계를 통일.
- **⚠️ JSON-LD 함정:** `<script type="application/ld+json">` 안에서 `{{ $dict | jsonify }}`만 쓰면 Go html/template이 `<script>` 컨텍스트로 보고 JSON 문자열을 **JS 문자열로 한 번 더 인코딩**해(`>"{\"@context\"...` 이중 이스케이프 → 구글이 파싱 못 함). 반드시 **`jsonify | safeJS`**로 끝낼 것. 현재 `app/list.html`의 SoftwareApplication 스키마가 이 패턴. 새 스키마 추가 시 동일 적용. (수정 커밋 3e4e61e)

### 설정 (`config/_default/`)

- `hugo.toml` — baseURL, 다국어 기본, `enableRobotsTXT = true`, `disableKinds = ["taxonomy","term","RSS"]` (RSS·태그·JSON 미생성)
- `languages.en.toml` / `languages.ko.toml` — 언어별 title·`description`(홈 h1)·`displayName`(언어 스위처) (`locale`/`label` 키 사용)
- `params.toml` — `supportEmail` 하나. 연락 주소의 **유일한 출처**다(푸터·앱 상세 문의·갤러리). `support@mongdaewon.com` 전환은 Cloudflare Email Routing 을 켜고 테스트 메일 도착을 확인한 **뒤에** 이 한 줄로 한다
- `markup.toml` — goldmark(`unsafe = true`)
- `static/` — 정적 파일, 빌드 시 사이트 루트로 복사: `app-ads.txt`, 파비콘(`favicon.ico`, `favicon-*.png`, `apple-touch-icon.png`, `android-chrome-*.png`, `site.webmanifest` — favicon.io 패키지, head 링크는 baseof.html), `img/badges/`(스토어 배지), `img/tools/`(도구 아이콘), `googled24a750a4d1fac6e.html`(구글 서치콘솔 소유확인 — 지우면 인증이 풀린다)
- `data/apps.toml` / `data/tools.toml` — 앱·도구 메타 단일 출처(위 참조)

**경로(URL) 안정성:** 콘텐츠 슬러그/경로는 SEO·색인에 영향을 주므로 함부로 바꾸지 않는다.

## 규칙

- *.md 파일은 반드시 UTF-8 인코딩
- Front matter는 YAML 형식(`---` 구분자) 사용
- 한국어로 소통
- 콘텐츠(앱 설명 등)에 em대시(—/–) 사용 금지, 하이픈(-) 사용

## my-wiki 연동

작업 전 읽기:
- `wiki/mobile/landing-site.md` — 앱 출시 시 이 사이트에서 하는 일의 **순서**(처리방침 URL 선확보)와 앱 쪽이 준비해 올 payload

**이 파일이 구조·포맷의 진실이다.** landing-site는 디렉토리 구조·front matter·CSS 규칙을 복제하지 않고 여기로 넘긴다. 위키를 갱신할 때도 그것들을 옮겨 적지 말 것.

작업 완료 후: 앱 등록·출시 상태가 바뀐 경우에만 `/wiki-sync`. (등록 앱 목록은 `data/apps.toml`이 단일 출처라 위키에 표를 두지 않는다.)
