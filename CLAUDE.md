# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

Mongdaewon 개발사의 Hugo 기반 정적 웹사이트. 모바일·데스크톱 앱 제품을 소개하는 회사 웹사이트.

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
        ├── _index.md / _index.ko.md   # type = "app"
        ├── icon.png                   # 실물 앱 아이콘 (256×256)
        └── privacy-policy/
            └── index.md               # 처리방침 (영어 단일)
```

현재 등록 앱(5개): Deep Breath, Ivy To Do, WidPass, Where Is My Cursor, JoinCut.

**앱 상세 페이지 콘텐츠 구조:** 앱 이름 → 1줄 킬링멘트(`params.tagline`) → 3줄 혜택(본문) → 다운로드 배지(하단) → 처리방침 링크. 본문은 기능 나열이 아니라 "사용자가 얻는 혜택" 중심으로 작성.

**새 앱 추가 시:**
1. `content/apps/<slug>/` 에 `_index.md`(+`.ko.md`) 생성, front matter에 `type = "app"`, `params.tagline`, 본문에 3줄 혜택.
2. `content/apps/<slug>/icon.png` (256×256 실물 아이콘) 배치.
3. `data/apps.toml`에 `[[app]]` 항목 추가(slug, name, 스토어 URL 등).
4. `content/apps/<slug>/privacy-policy/index.md` 처리방침 작성.

### 앱 메타데이터 단일 출처 — `data/apps.toml`

언어 무관 앱 메타(표시 순서, 이름, 스토어 링크, 이모지/색 fallback)는 `data/apps.toml`에서 한 곳으로 관리. 레이아웃이 slug로 매칭해 콘텐츠(제목/요약/본문, 언어별)와 결합.

- 스토어 링크는 **글로벌 형태**로: 애플은 `https://apps.apple.com/app/id{ID}` (country 코드·`mt=` 제거 → Apple이 접속자 지역으로 자동 리다이렉트). Google Play는 지역 파라미터 없이 `?id=...`.
- 필드: `appstore`, `macappstore`, `googleplay`, (선택) `comingsoon`.

### ⚠️ 스토어 다운로드 배지 — 순서·정렬 규칙

- **버튼 순서는 홈·앱 목록·앱 상세 등 어디서든 항상 동일하게 애플(App Store) → 안드로이드(Google Play) 순으로 정렬한다.** (Mac App Store는 애플 계열이므로 App Store 다음.) 있는 것만 노출하고 없으면 생략.
- 이 순서는 `layouts/partials/storebadges.html` **단일 파샬**이 강제한다(렌더 순서: `appstore` → `macappstore` → `googleplay`). 배지를 새로 렌더하는 곳이 생기면 반드시 이 파샬을 재사용할 것 — 순서를 손으로 나열하지 말 것.
- 배지 이미지(`static/img/badges/app-store.png`, `google-play.png`)는 **버튼만 있는 불투명 검은 사각형**(테두리·여백 없음, 동일 크기). 라운드(`border-radius`)·테두리(`border`)·간격(`gap`)은 전부 CSS가 담당하며, 다크모드에서는 테두리를 밝게 처리해 경계를 확보한다.

### 레이아웃 (`layouts/`)

```
layouts/
├── _default/baseof.html      # 뼈대(pico.css + 인라인 스타일 + 헤더/푸터 + 테마 토글)
├── _default/single.html      # 처리방침 등 단일 페이지
├── index.html                # 홈 (히어로 + 앱 리스트)
├── apps/list.html            # /apps/ 목록
├── app/list.html             # 앱 상세 (type="app" 섹션)
└── partials/
    ├── applist.html          # 앱 리스트 행 (홈·목록 공용)
    └── storebadges.html      # 스토어 배지 (순서 강제, 위 규칙 참조)
```

- CSS는 `baseof.html` 내 인라인 `<style>`에 집중. pico.css는 CDN(`jsdelivr`)에서 로드.
- 테마(라이트/다크) 토글은 헤더에 있으며 `data-theme` + `localStorage`로 유지. 미설정 시 `prefers-color-scheme` 따름.
- 앱 아이콘은 `.app-ico`에 CSS 테두리(`--pico-muted-border-color`)로 박스 경계를 통일.

### 설정 (`config/_default/`)

- `hugo.toml` — baseURL, 다국어 기본, `disableKinds = ["taxonomy","term","RSS"]` (RSS·태그·JSON 미생성)
- `languages.en.toml` / `languages.ko.toml` — 언어별 title/description/author (`locale`/`label` 키 사용)
- `params.toml` — 거의 비어 있음(테마 파라미터 없음)
- `markup.toml` — goldmark(`unsafe = true`)
- `static/` — 정적 파일(`app-ads.txt`, `img/badges/` 등), 빌드 시 사이트 루트로 복사
- `data/apps.toml` — 앱 메타 단일 출처(위 참조)

**경로(URL) 안정성:** 콘텐츠 슬러그/경로는 SEO·색인에 영향을 주므로 함부로 바꾸지 않는다.

## 규칙

- *.md 파일은 반드시 UTF-8 인코딩
- Front matter는 YAML 형식(`---` 구분자) 사용
- 한국어로 소통
- 콘텐츠(앱 설명 등)에 em대시(—/–) 사용 금지, 하이픈(-) 사용

## my-wiki 연동

작업 전 읽기:
- `wiki/mobile/landing-site.md` — 사이트 구조·등록 앱 현황

작업 완료 후 갱신:
- `wiki/mobile/landing-site.md` — 앱 현황 테이블 갱신
