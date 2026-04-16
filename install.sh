#!/usr/bin/env bash
# install.sh — ~/.claude/skills/ 에 이 레포의 스킬을 심볼릭 링크로 설치합니다.
# 사용법: bash install.sh

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
CATEGORIES=(git coding documentation productivity testing devops)

echo "📁 Skills 디렉토리 생성: $SKILLS_DIR"
mkdir -p "$SKILLS_DIR"

for category in "${CATEGORIES[@]}"; do
  category_path="$REPO_DIR/$category"
  if [ ! -d "$category_path" ]; then
    continue
  fi

  for skill_path in "$category_path"/*/; do
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
  done
done

echo ""
echo "완료! 설치된 스킬 목록:"
ls "$SKILLS_DIR"
