#!/usr/bin/env bash
# bootstrap — 이 레포로 작업할 환경을 만든다. 여러 번 돌려도 안전하다(멱등).
#
# 하는 일: 하네스 클론 확인·획득 → 전역 설치 → 이 레포의 조직·역할 선언 → 커밋 게이트.
# 하지 않는 일: 자격증명 취급. 공개키 등록·토큰 발급·env 설정은 사람이 한다 — 끝에 목록을 낸다.
#
# 환경변수:
#   HARNESS_ROOT   하네스 클론 위치 (기본: ~/src/<repo> — 없으면 클론한다)

set -eu

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
PROJECT="$(cd "$HERE/.." && pwd -P)"

HARNESS_REPO="https://github.com/JoNaYeon/ai-ops-harness.git"
HARNESS_REF="main"
ORG="none"
ROLE="none"

say() { printf '  %s\n' "$1"; }
echo "== bootstrap ($(basename "$PROJECT")) =="

# 1) 하네스 클론
HARNESS_ROOT="${HARNESS_ROOT:-$HOME/src/$(basename "$HARNESS_REPO" .git)}"
if [ -d "$HARNESS_ROOT/.git" ]; then
  say "하네스 클론 있음: $HARNESS_ROOT"
else
  say "하네스 클론: $HARNESS_REPO -> $HARNESS_ROOT"
  mkdir -p "$(dirname "$HARNESS_ROOT")"
  if ! git clone --quiet "$HARNESS_REPO" "$HARNESS_ROOT"; then
    echo "bootstrap: 하네스를 클론하지 못했다 — private 레포라면 이 계정에 접근 권한이 필요하다" >&2
    echo "  권한을 받은 뒤 다시 실행하거나, HARNESS_ROOT 로 기존 클론을 가리켜라." >&2
    exit 1
  fi
fi
[ -n "$HARNESS_REF" ] && git -C "$HARNESS_ROOT" checkout --quiet "$HARNESS_REF" 2>/dev/null || true
export HARNESS_ROOT

# 2) 전역 설치 (스킬·에이전트·훅·CLAUDE.md 블록)
if [ -f "$HARNESS_ROOT/scripts/install-global.sh" ]; then
  say "전역 설치"
  bash "$HARNESS_ROOT/scripts/install-global.sh" >/dev/null || say "전역 설치 실패 — 직접 확인하라"
fi

# 3) 이 레포의 조직·역할 선언 + 커밋 게이트
if [ -f "$HARNESS_ROOT/scripts/set-context.sh" ] && [ -f "$PROJECT/CLAUDE.md" ]; then
  say "컨텍스트 선언: org=$ORG role=$ROLE"
  bash "$HARNESS_ROOT/scripts/set-context.sh" --org "$ORG" --role "$ROLE" --project "$PROJECT" >/dev/null || true
fi
if [ -d "$PROJECT/.git" ]; then
  # 심볼릭 링크는 Windows 에서 복사로 강등되고, 그러면 훅이 HARNESS_ROOT 를 .git 으로 도출해
  # 셀프 검사가 조용히 스킵된다. hooksPath 는 원본을 직접 실행하므로 그 함정이 없다.
  git -C "$PROJECT" config core.hooksPath "$HARNESS_ROOT/scripts"
  say "커밋 게이트: core.hooksPath -> $HARNESS_ROOT/scripts"
fi

# 4) 사람이 해야 할 것
cat <<'MSG'

-- 남은 것 (자격증명은 사람이 한다) --
  1. SSH 키가 없으면 만들고 공개키를 이 계정의 GitHub 에 등록한다
  2. ~/.ssh/config 에 Host 별칭을 추가한다 (config 의 git.host_alias 값)
  3. MCP 토큰을 발급해 config 의 mcp.token_env 이름으로 env 에 넣는다
  4. config/ops.config.yml 의 빈 값을 채운다
  확인: bash "$HARNESS_ROOT/scripts/doctor.sh" --global
MSG
