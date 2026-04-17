#!/usr/bin/env bash
# install.sh — ~/.claude/skills/ 에 이 레포의 스킬을 설치합니다.
# 사용법: bash install.sh
#
# SKILL.md 파일을 가진 폴더를 재귀적으로 탐색하여 자동 설치합니다.
# _template/ 와 .claude/ 하위는 제외.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"

echo "📁 Skills 디렉토리 생성: $SKILLS_DIR"
mkdir -p "$SKILLS_DIR"

count=0
while IFS= read -r skill_md; do
  skill_path="$(dirname "$skill_md")"
  skill_name="$(basename "$skill_path")"
  target="$SKILLS_DIR/$skill_name"

  if [ -L "$target" ]; then
    echo "  ↩️  이미 링크됨: $skill_name"
  elif [ -d "$target" ]; then
    echo "  ⚠️  이미 존재함 (디렉토리): $skill_name"
  else
    ln -s "$skill_path" "$target"
    echo "  ✅ 링크 생성: /$skill_name"
    count=$((count + 1))
  fi
done < <(find "$REPO_DIR" -name "SKILL.md" -type f \
           -not -path "*/_template/*" \
           -not -path "*/.claude/*" \
           -not -path "*/.git/*")

echo ""
echo "완료! 새로 설치된 스킬 수: $count"
echo "총 설치된 스킬 수: $(find "$SKILLS_DIR" -maxdepth 2 -name "SKILL.md" | wc -l)"
