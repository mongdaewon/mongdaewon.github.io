#!/bin/bash
# 지난 28일 GSC 에서 노출은 있는데 클릭 0 인 검색어를 노출 순으로 뽑는다(Vaultaire 방식의 글감).
# 출력: [검색어, 페이지, 클릭, 노출, 평균 순위] 한 줄씩. 인자로 개수(기본 20).
set -euo pipefail
end=$(date -v-2d +%F); start=$(date -v-30d +%F)   # 최근 2일은 GSC 집계가 늦다
node /Users/daewonbrothers/repository/tools/analytics/query.mjs gsc \
  "{\"siteUrl\":\"sc-domain:mongdaewon.com\",\"startDate\":\"$start\",\"endDate\":\"$end\",\"dimensions\":[\"query\",\"page\"],\"rowLimit\":1000}" |
  jq -c "map(select(.[2]==0)) | sort_by(-.[3]) | .[:${1:-20}][]"
