#!/usr/bin/env bash
# install.sh — ~/.claude/commands/ 에 이 레포의 슬래시 커맨드를 설치합니다.
# 사용법: bash install.sh
#
# .claude/commands/ 하위의 모든 커맨드 파일을 ~/.claude/commands/ 에 심볼릭 링크로 설치.
# 서브디렉터리 구조(/work/git/start 등)를 그대로 유지합니다.

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/.claude/commands"
DEST_DIR="$HOME/.claude/commands"

if [ ! -d "$SRC_DIR" ]; then
  echo "❌ $SRC_DIR 가 존재하지 않습니다."
  exit 1
fi

echo "📁 Commands 디렉토리 생성: $DEST_DIR"
mkdir -p "$DEST_DIR"

# .md 파일을 찾아 심볼릭 링크 생성. 서브디렉터리 구조 유지.
while IFS= read -r src_file; do
  rel="${src_file#$SRC_DIR/}"
  dest="$DEST_DIR/$rel"
  dest_parent="$(dirname "$dest")"

  mkdir -p "$dest_parent"

  if [ -L "$dest" ]; then
    echo "  ↩️  이미 링크됨: /$rel (건너뜀)"
  elif [ -f "$dest" ]; then
    echo "  ⚠️  이미 존재함 (파일): /$rel (건너뜀)"
  else
    ln -s "$src_file" "$dest"
    # 슬래시 커맨드 이름은 확장자 제거
    cmd="/${rel%.md}"
    echo "  ✅ 링크 생성: $cmd"
  fi
done < <(find "$SRC_DIR" -name "*.md" -type f)

echo ""
echo "완료! 설치된 커맨드 수: $(find "$DEST_DIR" -name "*.md" -type f | wc -l)"
