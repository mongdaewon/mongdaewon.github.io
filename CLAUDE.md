# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

Mongdaewon 개발사의 Hugo 기반 정적 웹사이트. Blowfish 테마(Tailwind CSS 기반)를 사용하며, 모바일 앱 제품(Deep Breath 등)을 소개하는 회사 웹사이트.

- **사이트 URL:** https://mongdaewon.github.io/
- **Hugo 버전:** 0.154.2 (extended)
- **테마:** Blowfish (git submodule, `themes/blowfish`)

## 주요 명령어

```bash
# 로컬 개발 서버
hugo server

# 프로덕션 빌드
hugo --gc --minify

# 서브모듈 포함 클론
git clone --recurse-submodules
```

배포는 main 브랜치 push 시 GitHub Actions가 자동으로 빌드 및 GitHub Pages에 배포.

## 아키텍처

### 다국어 구조

기본 언어는 영어(`en`), 한국어(`ko`)를 추가 지원. 콘텐츠 파일명 규칙:
- 영어: `_index.md` 또는 `index.md`
- 한국어: `_index.ko.md` 또는 `index.ko.md`

언어별 설정은 `config/_default/languages.*.toml` 파일에서 관리.

### 콘텐츠 구조

```
content/
├── _index.md / _index.ko.md          # 홈페이지
└── apps/
    ├── _index.md / _index.ko.md      # 앱 목록 페이지
    └── deep-breath/                   # 개별 앱 (Hugo Page Bundle)
        ├── _index.md / _index.ko.md
        └── privacy-policy/
            └── index.md               # 프라이버시 정책 (영어 단일)
```

새 앱 추가 시 `content/apps/` 아래에 동일한 번들 구조로 디렉토리 생성. 카드 썸네일은 번들 내 `feature.png` 또는 `feature.jpg` 파일로 자동 생성.

### 설정

설정은 `config/_default/` 디렉토리에 분리된 TOML 파일로 관리:

- `config/_default/hugo.toml` — 사이트 기본 설정 (baseURL, theme, outputs)
- `config/_default/languages.en.toml` — 영어 설정 (title, author, description)
- `config/_default/languages.ko.toml` — 한국어 설정
- `config/_default/menus.en.toml` — 영어 메뉴
- `config/_default/menus.ko.toml` — 한국어 메뉴
- `config/_default/params.toml` — 테마 파라미터 (homepage layout, colorScheme 등)
- `config/_default/markup.toml` — 마크업 설정
- `static/` — 정적 파일 (app-ads.txt 등), 빌드 시 사이트 루트에 복사
- `themes/blowfish/` — 테마 서브모듈, 직접 수정하지 않음

## 규칙

- *.md 파일은 반드시 UTF-8 인코딩
- Front matter는 YAML 형식 (`---` 구분자) 사용
- 한국어로 소통
