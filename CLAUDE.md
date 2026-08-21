# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

Mongdaewon 개발사의 Hugo 기반 정적 웹사이트. 모바일·맥 앱 + 웹 도구(itool.co.kr) + 크롬 확장을 소개하는 회사 웹사이트.

- **사이트 URL:** https://mongdaewon.github.io/
- **Hugo 버전:** 0.163.2 (extended) — GitHub Actions 워크플로에 고정
- **테마:** 없음. 직접 작성한 `layouts/`(순수 HTML) + **pico.css**(CDN)로 구성. Blowfish 테마는 제거됨.

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

현재 등록 앱(6개): Deep Breath, Ivy To Do, WidPass, Where Is My Cursor, JoinCut, RecNow.

**앱 상세 페이지 콘텐츠 구조:** 앱 이름 → 1줄 킬링멘트(`params.tagline`) → 3줄 혜택(본문) → 다운로드 배지(하단) → 처리방침 링크. 본문은 기능 나열이 아니라 "사용자가 얻는 혜택" 중심으로 작성.

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
⚠️ **처리방침 URL은 스토어 제출 전에 확보한다.** 페이지 생성 → main push → `https://mongdaewon.github.io/apps/<slug>/privacy-policy/` 200 확인 순서.

### 앱 메타데이터 단일 출처 — `data/apps.toml`

언어 무관 앱 메타(표시 순서, 이름, 스토어 링크, 이모지/색 fallback)는 `data/apps.toml`에서 한 곳으로 관리. 레이아웃이 slug로 매칭해 콘텐츠(제목/요약/본문, 언어별)와 결합.

- 스토어 링크는 **글로벌 형태**로: 애플은 `https://apps.apple.com/app/id{ID}` (country 코드·`mt=` 제거 → Apple이 접속자 지역으로 자동 리다이렉트). Google Play는 지역 파라미터 없이 `?id=...`.
- 필드: `appstore`, `macappstore`, `googleplay`, (선택) `comingsoon`.

### 웹 도구·크롬 확장 — `data/tools.toml` (홈 "Tools" 섹션)

앱 외 자사 웹 도구·브라우저 확장은 `data/tools.toml`에서 관리하며, 홈/`apps` 페이지의 Apps 리스트 **아래 "Tools" 섹션**(`partials/toolslist.html`)에 노출.

- 필드: `slug`, `name`/`name_ko`, `desc`/`desc_ko`, `url`/`url_ko`, `kind`(`"web"` | `"chrome"`).
- **base 필드는 영어, `_ko` 접미사가 한국어 override**(없으면 base로 fallback). `url_ko`도 동일 — 예: iTool은 en `https://itool.co.kr/en/`, ko `https://itool.co.kr`.
- `kind = "web"` → "Visit/웹사이트" 텍스트 버튼. `kind = "chrome"` → **공식 Chrome Web Store 배지**(라이트/다크 두 변형을 CSS로 테마 스왑).
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
- 이 순서는 `layouts/partials/storebadges.html` **단일 파샬**이 강제한다(렌더 순서: `appstore` → `macappstore` → `googleplay`). 배지를 새로 렌더하는 곳이 생기면 반드시 이 파샬을 재사용할 것 — 순서를 손으로 나열하지 말 것.
- 배지 이미지(`static/img/badges/app-store.png`, `google-play.png`)는 **버튼만 있는 불투명 검은 사각형**(테두리·여백 없음, 동일 크기). 라운드(`border-radius`)·테두리(`border`)·간격(`gap`)은 전부 CSS가 담당하며, 다크모드에서는 테두리를 밝게 처리해 경계를 확보한다.
- 크롬 확장은 공식 **Chrome Web Store 배지**(`static/img/badges/chrome-web-store-light.png` = 흰배경용 투명, `-dark.png` = 컬러배경용 흰색 채움)를 `.chrome-badge.light`/`.chrome-badge.dark` 클래스로 테마 스왑한다.

### 레이아웃 (`layouts/`)

```
layouts/
├── _default/baseof.html      # 뼈대(pico.css + 인라인 스타일 + 헤더/푸터 + 테마 토글)
├── _default/single.html      # 처리방침 등 단일 페이지
├── index.html                # 홈 (히어로 + 앱 리스트 + 도구 리스트)
├── apps/list.html            # /apps/ (앱 리스트 + 도구 리스트)
├── app/list.html             # 앱 상세 (type="app" 섹션)
└── partials/
    ├── applist.html          # 앱 리스트 행 (홈·목록 공용)
    ├── toolslist.html        # Tools 섹션 (data/tools.toml 기반)
    └── storebadges.html      # 스토어 배지 (순서 강제, 위 규칙 참조)

layouts/robots.txt              # robots + sitemap 위치 (enableRobotsTXT = true)
```

- CSS는 `baseof.html` 내 인라인 `<style>`에 집중. pico.css는 CDN(`jsdelivr`)에서 로드.
- **폰트: Pretendard Variable**(jsdelivr, dynamic-subset). `--pico-font-family`로 주입.
- **타이포는 `:root`의 5단계 토큰만 쓴다** — `--fs-sm`(.875) `--fs-base`(1) `--fs-lg`(1.125) `--fs-xl`(1.25) `--fs-2xl`(1.5). 새 `font-size`에 임의값(`.86rem` 등)을 쓰지 말 것. 웨이트는 400·700 두 개만.
- **radius는 `--pico-border-radius`(8px) 하나.** 앱 아이콘(14/19px)만 iOS 아이콘 관례상 예외.
- 리스트 행은 구분선이 아니라 **간격**으로 나눈다(`.app-list { gap: 1.5rem }`). 다크에서 구분선이 ~1.3:1로 사라졌던 이력.
- `<link rel=canonical>`은 baseof에서 생성. front matter `canonicalHome: true`인 페이지(`content/apps/_index.md*`)는 홈을 가리켜 홈/`/apps/` 중복을 정리한다.
- 테마(라이트/다크) 토글은 헤더에 있으며 `data-theme` + `localStorage`로 유지. 미설정 시 `prefers-color-scheme` 따름.
- 앱 아이콘은 `.app-ico`에 CSS 테두리(`--pico-muted-border-color`)로 박스 경계를 통일.
- **⚠️ JSON-LD 함정:** `<script type="application/ld+json">` 안에서 `{{ $dict | jsonify }}`만 쓰면 Go html/template이 `<script>` 컨텍스트로 보고 JSON 문자열을 **JS 문자열로 한 번 더 인코딩**해(`>"{\"@context\"...` 이중 이스케이프 → 구글이 파싱 못 함). 반드시 **`jsonify | safeJS`**로 끝낼 것. 현재 `app/list.html`의 SoftwareApplication 스키마가 이 패턴. 새 스키마 추가 시 동일 적용. (수정 커밋 3e4e61e)

### 설정 (`config/_default/`)

- `hugo.toml` — baseURL, 다국어 기본, `enableRobotsTXT = true`, `disableKinds = ["taxonomy","term","RSS"]` (RSS·태그·JSON 미생성)
- `languages.en.toml` / `languages.ko.toml` — 언어별 title/description/author (`locale`/`label` 키 사용)
- `params.toml` — 거의 비어 있음(테마 파라미터 없음)
- `markup.toml` — goldmark(`unsafe = true`)
- `static/` — 정적 파일, 빌드 시 사이트 루트로 복사: `app-ads.txt`, 파비콘(`favicon.ico`, `favicon-*.png`, `apple-touch-icon.png`, `android-chrome-*.png`, `site.webmanifest` — favicon.io 패키지, head 링크는 baseof.html), `img/badges/`(스토어·크롬 배지), `img/tools/`(도구 아이콘), `googled24a750a4d1fac6e.html`(구글 서치콘솔 소유확인 — 지우면 인증이 풀린다)
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
