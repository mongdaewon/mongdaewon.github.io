# TODO

## 사이트

- [ ] AudioJoin 처리방침 분석 항목에 "구매(상품·가격, 결제 정보 제외)" 한 줄
      App Store 개인정보 라벨에 "구입 항목"(분석, 신원 연결 안 됨)을 2026-11-26 게시했다 — 앱이 구매를 GA4 로 보낸다(`Analytics.logTransaction`).
      `content/apps/audiojoin/privacy-policy/index.md` §Firebase Analytics 수집 목록에 더하고 `Last updated` 를 바꾼다. 다른 언어 판도 같이.
- [ ] 페이지에 og 태그(og:title·og:description·og:image) 넣기
      네이버 블로그 글에 이 사이트 주소를 넣으면 카드 설명이 `description` 대신 본문 첫 줄(`← 블로그 …`)로 나오고 그림이 없다(2026-11-26 몽대원 블로그 3편 실측). `layouts/_default/baseof.html` 에 og 태그가 없다.
      고친 뒤 몽대원 블로그 쪽에서 카드를 다시 붙여 갱신한다.

## 블로그 새 글 (하루 1개, 2026-11-17 우버서제스트 미국 검색량)
글 하나 = 그날 키워드로 `/google-keyword` 재확인 → 앱 레포 기능·스크린샷 대조 → 발행·색인·월간 리뷰 기준선.
- [ ] 아이폰 PDF 용량 줄이기 글 (JoinPDF) @11/26
      compress pdf iphone 390 · 30, reduce pdf size iphone 210 · 33. Size 무료/Plus 범위는 앱 레포에서 그날 다시 확인.
- [ ] 아이폰 할 일 위젯 글 (Ivy To Do) @11/27
      to do list widget iphone 320 · 29, daily to-do list app 320 · 16.
- [ ] 아이폰 영상 GIF 만들기 글 (JoinCut) @11/28
      video to gif iphone 320 · 46(어려움). 무료는 워터마크.
- [ ] 오디오 볼륨 고르게 맞추기 글 (JoinSound) @11/29
      normalize audio volume 140 · 27, make audio louder iphone 30 · 30. 볼륨 맞추기는 무료(AudioJoin 엔 없음).
- [ ] 아이폰 음성 메모 자르기 글 (AudioJoin) @11/30
      trim voice memo iphone 40 · 31, shorten audio file iphone 20 · 13. 자르기는 무료, 0.1초 단위.
- [ ] 박스 호흡 vs 4-7-8 글 쓸지 정하기 (Deep Breath)
      box breathing vs 4-7-8 590 · 27, 4-7-8 breathing timer 110 · 14, how to do 4-7-8 breathing 70 · 10(11/25 우버서제스트). box-breathing-app 글의 비교 표와 안 겹치게.
- [ ] 경쟁 앱 비교 글 후보 고르기 @12/1
      앱마다 스토어 상위 경쟁 앱을 받아 보고, 우리가 확연히 나은 점(무손실·무료 범위·업로드 없음·광고 없음 등)이 앱 레포로 확인되는 것만 남긴다.
      `<경쟁앱> alternative`·`<경쟁앱> vs`·`best <분류> app` 을 /google-keyword 로 재고 의도가 기존 글과 겹치면 기존 글 표에 넣는다.

## 한국어 블로그 시험 3편 (2026-11-24 시작)
규칙은 AGENTS §블로그. 우버서제스트 한국 검색량·난이도, 기준선 0.
- [ ] 한국어 3편 4주 결과 보고 계속할지 정하기 @12/24
      GSC `/ko/blog/` 노출·클릭, cta_click. 네이버 글과 같은 검색어에서 겹치는지도 본다.

## 포기하면 안돼 덱 마켓 웹 페이지
구조·규칙은 AGENTS §포기하면 안돼 덱 마켓.
- [ ] 👤 아이폰 카메라로 덱 QR 찍어 앱 덱 상세 열림 확인
      링크 처리는 확인됨(11/10 iOS 출시판 devicectl, Android Play판 adb 둘 다 덱 상세). 남은 건 카메라·사파리 배너 [열기]·메시지 링크 경로. 11/10 QR 이 홈으로만 열렸다(디버그판도 깔려 있었다)

## 도메인 전환 후속 (mongdaewon.com, 2026-10-01)
- [ ] 옛 github.io GSC 속성 정리 @4/1
      2027-04 이후(주소 변경 180일). **그 전엔 지우지 않는다.**
