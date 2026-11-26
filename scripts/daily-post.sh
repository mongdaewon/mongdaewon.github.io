#!/bin/bash
# 하루 한 편 블로그 새 글 초안을 headless Claude 로 쓰고 텔레그램으로 알린다. push(=배포)는 하지 않는다.
# launchd(com.mongdaewon.daily-post)가 매시·로그인 때 부르고, 오늘 이미 끝났으면 바로 나간다 -
# 잠자기·꺼짐·잠금으로 놓쳐도 깨어나 로그인된 첫 정시에 돈다. 실패하면 그날 한 번 더 시도한다.
#   scripts/daily-post.sh          보통 실행
#   scripts/daily-post.sh --force  오늘 이미 했어도 다시
set -uo pipefail
export PATH="/opt/homebrew/bin:$HOME/.local/bin:/usr/local/bin:$PATH"   # launchd PATH 에는 brew·claude 가 없다
R=/Users/daewonbrothers/repository/web/github-pages/mongdaewon
W=/Users/daewonbrothers/repository/web/github-pages/mongdaewon-daily   # 초안용 worktree(메인 체크아웃을 안 건드린다)
S=$HOME/.cache/mongdaewon-daily-post; mkdir -p "$S"
today=$(TZ=Asia/Seoul date +%F); hour=$(TZ=Asia/Seoul date +%-H)

if [[ "${1:-}" != --force ]]; then
  [[ "$(cat "$S/done" 2>/dev/null)" == "$today" ]] && exit 0
  (( hour < 9 )) && exit 0                                   # 새벽에 잠깐 깬 맥에서는 안 돈다
  tries=$(rg -c "^$today$" "$S/tries" 2>/dev/null || echo 0)
  (( tries >= 2 )) && exit 0                                 # ponytail: 하루 2번 실패하면 내일로
fi
echo "$today" >> "$S/tries"

tg() {  # 텔레그램 한 통(키체인 retro-telegram, 개인 자동화와 같은 봇)
  curl -s -o /dev/null "https://api.telegram.org/bot$(security find-generic-password -s retro-telegram -a token -w)/sendMessage" \
    --data-urlencode "chat_id=$(security find-generic-password -s retro-telegram -a chat -w)" --data-urlencode "text=$1"
}

git -C "$R" fetch -q origin main
[[ -d "$W" ]] && git -C "$R" worktree remove --force "$W"   # 어제 초안 브랜치는 남는다(폴더만 치움)
git -C "$R" worktree add -q -B "post/$today" "$W" origin/main || { tg "블로그 초안 실패: worktree"; exit 1; }
drafts=$(git -C "$R" for-each-ref --format='%(refname:short) %(contents:subject)' 'refs/heads/post/*' | rg -v "^post/$today ")

prompt="오늘($today) mongdaewon.com 블로그 새 글 한 편의 초안을 이 worktree(브랜치 post/$today, origin/main 기준)에 만든다.
사람은 지금 없다. 묻지 말고 끝까지 하고, 막히면 거기까지 커밋한 뒤 무엇이 막혔는지 보고한다.

1. 주제: TODO.md 「블로그 새 글」 절에서 @M/D 가 오늘 이하인 항목 중 가장 이른 것 하나.
   이미 초안 브랜치가 있는 주제는 건너뛴다:
${drafts:-   (없음)}
   남은 항목이 없으면 /Users/daewonbrothers/repository/web/github-pages/mongdaewon/scripts/gsc-zero-click.sh 로 노출 있고 클릭 0 인 검색어를 보고, 그것도 마땅치 않으면
   /google-keyword 로 우리 앱이 답하는 새 질문 하나를 고른다(기존 글과 의도가 겹치면 안 된다).
2. AGENTS.md 블로그 절 규칙대로 쓴다: 키워드 확인, 앱 레포로 사실·무료 범위 확인, 단계마다 빨간 박스 캡처(공용 시뮬레이터 잠금),
   첫 문장에서 답하기, 옆 글과 서로 링크, front matter date: $today. 독자용 글이므로 content-style README 를 먼저 읽는다.
3. hugo --gc --minify 로 빌드가 되는지 본다.
4. TODO.md 에서 그 항목을 지우고(이 브랜치에서만), 바뀐 파일만 골라 커밋한다. push·머지·main 체크아웃은 하지 않는다.
5. 마지막 답은 그대로 텔레그램으로 간다. 한국어 5줄 이내: 제목 / 경로(/blog/<slug>/) / 그림 수 / 사람이 확인할 점."

log="$S/$today.log"
out=$( (cd "$W" && \
  "$HOME/.local/bin/claude" -p "$prompt" --permission-mode auto --disallowedTools 'Bash(git push:*)' ) 2>>"$log" )
rc=$?
echo "$out" >> "$log"
if (( rc == 0 )) && [[ -n "$(git -C "$W" log origin/main..HEAD --oneline)" ]]; then
  echo "$today" > "$S/done"
  tg "📝 블로그 초안 (post/$today)
$out

배포: Claude 세션에서 「오늘 글 배포」"
else
  tg "블로그 초안 실패 (exit $rc, 시도 $(rg -c "^$today$" "$S/tries")/2). 로그: $log
$(tail -c 600 <<<"$out")"
  exit 1
fi
