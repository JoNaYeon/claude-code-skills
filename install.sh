#!/usr/bin/env bash
# install.sh — ~/.claude/skills/ 에 이 레포의 스킬을 심볼릭 링크로 설치합니다.
# 사용법: bash install.sh
#
# SKILL.md 파일을 가진 폴더를 재귀적으로 탐색하여 자동 설치합니다.
# _template/ 하위는 제외 (보일러플레이트).

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo "📁 Skills 디렉토리 생성: $SKILLS_DIR"
mkdir -p "$SKILLS_DIR"

# SKILL.md 를 가진 모든 폴더를 찾되, _template/ 와 .git/ 은 제외
while IFS= read -r skill_md; do
  skill_path="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_path")"
  target="$SKILLS_DIR/$skill_name"

  if [ -L "$target" ]; then
    echo "  ↩️  이미 링크됨: $skill_name (건너뜀)"
  elif [ -d "$target" ]; then
    echo "  ⚠️  이미 존재함 (디렉토리): $skill_name (건너뜀)"
  else
    ln -s "$skill_path" "$target"
    echo "  ✅ 링크 생성: $skill_name"
  fi
done < <(find "$REPO_DIR" -name "SKILL.md" -type f \
           -not -path "*/_template/*" \
           -not -path "*/.git/*")

echo ""
echo "완료! 설치된 스킬 목록:"
ls "$SKILLS_DIR"
