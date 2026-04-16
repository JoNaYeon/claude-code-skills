# Claude Code Skills

Claude Code에서 사용하는 개인 스킬 템플릿 모음입니다.

---

## 스킬 목록

### 🖥️ Coding
| 스킬 | 설명 |
|------|------|
| [code-review](./coding/code-review/SKILL.md) | 코드 품질·보안·성능·가독성 체계적 리뷰 |
| [refactor-guide](./coding/refactor-guide/SKILL.md) | 코드 스멜 탐지 및 리팩토링 제안 |

### 📄 Documentation
| 스킬 | 설명 |
|------|------|
| [api-docs](./documentation/api-docs/SKILL.md) | 소스 코드 기반 API 문서 자동 생성 |

### ⚡ Productivity
| 스킬 | 설명 |
|------|------|
| [commit-message](./productivity/commit-message/SKILL.md) | 변경사항 분석 후 Conventional Commits 메시지 생성 |

### 🧪 Testing
| 스킬 | 설명 |
|------|------|
| [test-generator](./testing/test-generator/SKILL.md) | 함수/모듈에 대한 단위 테스트 자동 생성 |

### 🐳 DevOps
| 스킬 | 설명 |
|------|------|
| [dockerfile](./devops/dockerfile/SKILL.md) | Dockerfile 생성 및 베스트 프랙티스 기반 리뷰 |

---

## 스킬 파일 형식

각 스킬은 `SKILL.md` 파일로 구성됩니다.

```markdown
---
name: skill-name
description: "Claude가 이 스킬을 사용할 시점을 설명합니다."
---

# 스킬 이름

## 목적
...

## 지침
...
```

- **`name`**: 고유 식별자 (kebab-case)
- **`description`**: Claude의 트리거 조건 — 언제 이 스킬을 써야 하는지 구체적으로 기술할수록 좋습니다
- **본문**: 마크다운으로 작성하는 실행 지침

---

## 설치하기 (전역 — 모든 프로젝트에 적용)

`~/.claude/skills/` 에 설치하면 SSH로 접속한 프로젝트 포함, **모든 프로젝트에서 자동으로 스킬이 인식**됩니다.

```bash
# 1. 레포 클론 (한 번만)
git clone https://github.com/JoNaYeon/claude-code-skills.git ~/claude-code-skills

# 2. 설치 스크립트 실행 (심볼릭 링크 자동 생성)
cd ~/claude-code-skills
bash install.sh
```

이후 레포에 새 스킬이 추가되면:
```bash
cd ~/claude-code-skills && git pull
bash install.sh  # 새 스킬만 추가로 링크됨
```

---

## 설치하기 (프로젝트별)

특정 프로젝트에만 스킬을 넣고 싶을 때:

```bash
cp -r coding/code-review /path/to/your-project/.claude/skills/
```

Windows (PowerShell):
```powershell
Copy-Item -Recurse coding\code-review .claude\skills\
```

---

## 새 스킬 만들기

1. **템플릿 복사**
   ```bash
   cp -r _template/skill-name <category>/<new-skill-name>
   ```

2. **SKILL.md 편집**
   - `name`: 스킬 이름 변경
   - `description`: 트리거 조건 작성 (구체적일수록 좋음)
   - 본문: 지침 작성

3. **이 README에 스킬 추가**
   - 해당 카테고리 테이블에 한 줄 추가

4. **커밋 & 푸시**

---

## 폴더 구조

```
claude-code-skills/
├── _template/          # 새 스킬 생성용 보일러플레이트
│   └── skill-name/
│       └── SKILL.md
├── coding/
│   ├── code-review/
│   └── refactor-guide/
├── documentation/
│   └── api-docs/
├── productivity/
│   └── commit-message/
├── testing/
│   └── test-generator/
└── devops/
    └── dockerfile/
```

필요에 따라 `scripts/`, `references/`, `assets/` 서브 폴더를 스킬 폴더 내에 추가할 수 있습니다.

---

## License

MIT
