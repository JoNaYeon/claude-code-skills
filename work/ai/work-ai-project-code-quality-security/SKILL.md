---
name: work-ai-project-code-quality-security
description: "Use this skill to set up code quality and security standards for a project. Triggers on: 'code quality', 'security standards', 'lint setup', 'security audit setup', '코드 품질', '보안 설정'."
---


# Project Code Quality And Security: {{title}}

> Purpose: 이 프로젝트의 코드 품질 게이트와 AI 보안 방어 체계를 하나의 문서로 통합한다.
> 사람과 AI 협업자 모두 이 문서를 기준으로 검증한다.

Reference:
- [[03_Project Git Workflow]]

## 1. Project Snapshot

> 이 섹션의 값은 [[00_Project Context]] 에서 가져온다.

- Project / workstream:
- Repo path:
- Main languages:
- Runtime environments:
- Primary owner:
- Typical collaborators:
- Stable branch:
- Highest-risk areas:
- Has .env files: yes / no
- Has API keys in use: yes / no
- Claude Code settings path:
- Pre-commit config path:

## 2. Quality Principles

- Prefer fast local feedback before slow remote feedback.
- Automate style decisions so review time stays focused on behavior, correctness, and risk.
- Use at least 3 quality layers when possible:
  - editor or local autofix
  - commit-time validation
  - CI or merge-time validation
- Block merges on correctness gates, not only on formatting.
- Keep exceptions explicit, narrow, and documented with a reason.
- Treat complexity, dead-code, and maintainability metrics as signals first; promote them to blocking gates only when the team is ready.

## 3. Quality Stack

| Layer | Tool | Role | Scope | Config path | Blocking |
|---|---|---|---|---|---|
| Editor |  | Save-time autofix / formatting |  |  | no |
| Commit hook |  | Changed-file lint and hygiene |  |  | yes |
| Type / contract check |  | Type safety or schema validation |  |  | yes |
| Tests |  | Regression protection |  |  | yes |
| CI |  | Final merge gate |  |  | yes |
| Report-only metrics |  | Complexity / dead code / maintainability trend |  |  | no |

## 4. 3-Layer Feedback Loop

```text
Layer 1 — Editor / local autofix
  - formatter
  - import/order cleanup
  - simple safe fixes

Layer 2 — Pre-commit / local validation
  - lint on touched files
  - type or contract checks
  - script / config hygiene
  - gitleaks secret scan
  - fail the commit if unresolved issues remain

Layer 3 — CI / merge gate
  - full-project lint
  - format check
  - type or contract checks
  - test suite
  - optional build, package, or smoke check
```

Rules:
- If one of the 3 layers does not exist yet, record the gap in §12 and the compensating control.
- Keep Layer 1 fast enough to run on every save.
- Keep Layer 2 fast enough that developers do not feel pressure to bypass it.
- Keep Layer 3 authoritative: if CI fails, the change is not ready to merge.

## 5. Security 5-Layer 방어 체계

### 5.0 위협 모델

AI 에이전트는 파일을 읽고, 수정하고, 커밋하는 권한을 가진다.
기존 보안 체계(`.gitignore`, pre-commit)는 **사람이 커밋하는 시점**만 방어한다.

| 위협 | 시나리오 | 결과 |
|---|---|---|
| 컨텍스트 유출 | AI가 `.env`를 읽음 | 토큰이 AI 응답/로그에 노출 |
| 설정 오염 | AI가 `.env`를 "수정" | 토큰이 덮어쓰기되거나 삭제됨 |
| Permission 하드코딩 | `settings.local.json`에 Bearer 토큰 평문 기록 | 설정 파일이 곧 시크릿 파일이 됨 |
| Git 히스토리 오염 | AI가 토큰 포함 파일을 stage/commit | 히스토리에 시크릿이 영구 기록 |

### 5.1 Layer 0 — CLAUDE.md 규칙 (AI 행동 자제)

모든 프로젝트의 CLAUDE.md에 아래 블록을 추가한다:

```markdown
## Security Rules
- NEVER read, open, or cat any .env file. Use .env.example for reference.
- NEVER include API keys, tokens, or secrets in code, comments, or commit messages.
- NEVER hardcode credentials in configuration files or permission rules.
- If a task requires an API key value, ask the user — do not read it from files.
- When writing curl commands, use environment variable references ($VAR) instead of literal token values.
```

적용 확인:
- [ ] 이 프로젝트의 CLAUDE.md에 Security Rules 블록이 있는가

### 5.2 Layer 1 — Claude Code PreToolUse Hooks (자동 차단)

AI가 Read/Edit/Write 도구를 사용할 때 파일 경로를 검사하여, 시크릿 파일이면 `exit 2`로 차단한다.

**secret-guard.sh:**

```bash
#!/bin/bash
# secret-guard.sh — Claude Code PreToolUse hook
BLOCKED_PATTERNS='\.env$|\.env\.|secrets\.|credentials\.|service-account.*\.json$|\.ssh/|\.gnupg/'

FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "import sys,json; d=json.loads(sys.stdin.read()); print(d.get('file_path','') or d.get('path',''))" 2>/dev/null)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if echo "$FILE_PATH" | grep -qE "$BLOCKED_PATTERNS"; then
  BASENAME=$(basename "$FILE_PATH")
  echo "BLOCKED: AI must not access secret file: $BASENAME" >&2
  echo "Use .env.example for reference instead." >&2
  exit 2
fi

exit 0
```

**settings.local.json hooks 설정:**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Read",
        "hooks": [{ "type": "command", "command": "bash /path/to/scripts/secret-guard.sh", "statusMessage": "Checking secret file access..." }]
      },
      {
        "matcher": "Edit",
        "hooks": [{ "type": "command", "command": "bash /path/to/scripts/secret-guard.sh", "statusMessage": "Checking secret file access..." }]
      },
      {
        "matcher": "Write",
        "hooks": [{ "type": "command", "command": "bash /path/to/scripts/secret-guard.sh", "statusMessage": "Checking secret file access..." }]
      }
    ]
  }
}
```

적용 확인:
- [ ] `scripts/secret-guard.sh` 파일이 존재하고 `chmod +x` 되어 있는가
- [ ] `.claude/settings.local.json`에 PreToolUse hooks가 설정되어 있는가
- [ ] hooks의 script 경로가 이 기기의 실제 경로와 일치하는가

### 5.3 Layer 2 — Pre-commit gitleaks

`.pre-commit-config.yaml`에 추가:

```yaml
- repo: https://github.com/gitleaks/gitleaks
  rev: v8.24.0
  hooks:
    - id: gitleaks
      name: "gitleaks secret scan"
```

설치: `brew install gitleaks`

> 비코드 프로젝트인 경우 선택 사항이나, `.mcp.json` 등에 토큰 실수 방지를 위해 권장.

적용 확인:
- [ ] `.pre-commit-config.yaml`에 gitleaks가 있는가
- [ ] `gitleaks` 바이너리가 설치되어 있는가

### 5.4 Layer 3 — .gitignore 표준 패턴

모든 프로젝트에 아래 패턴을 기본으로 포함한다:

```gitignore
# === 시크릿 파일 — 절대 추적하지 않음 ===
**/.env
**/.env.*
!**/.env.example
*.env.save
*.env.local
*.env.backup
**/secrets.*
**/credentials.*
**/service-account*.json

# === Claude Code 로컬 설정 ===
.claude/settings.local.json
```

적용 확인:
- [ ] `.gitignore`에 `**/.env` 패턴이 있는가
- [ ] `.env.example`은 제외 처리(`!`)되어 있는가
- [ ] `settings.local.json`이 추적에서 제외되어 있는가

### 5.5 Layer 4 — Permission 위생

금지:
- `settings.local.json` permission 규칙에 **실제 토큰값을 넣지 않는다**
- `Bearer sk-xxx`, `ghp_xxx`, `bot_token` 등이 평문으로 있으면 즉시 제거

안전한 대안:
```json
// 위험: 토큰이 settings 파일에 평문으로 존재
"Bash(curl -H 'Authorization: Bearer sk-실제토큰값' ...)"

// 안전: 환경변수 참조
"Bash(curl -H \"Authorization: Bearer $MY_TOKEN\" ...)"
```

적용 확인:
- [ ] `settings.local.json`에 평문 토큰이 없는가
- [ ] 필요한 토큰이 셸 환경변수로 설정되어 있는가

## 6. Validation By Change Type

### Application code changes
- Minimum required commands:
- Lint / formatter commands:
- Type / contract commands:
- Test commands:
- Optional deeper checks:

### Script, infra, or ops changes
- Static analysis commands:
- Dry-run commands:
- Smoke-check commands:
- Rollback or recovery check:

### Skill, config, or setting file changes (비코드 프로젝트용)
- Skill file structural checks:
- Config file syntax validation:
- Cross-reference consistency:
- CLAUDE.md impact check:

### Docs-only changes
- Cross-link or reference consistency checks:
- Template or example verification:
- Which project status docs must be updated together:

### API, schema, or migration changes
- Backward compatibility checks:
- Migration rehearsal steps:
- Consumer impact checks:

### Security-sensitive changes
- Extra review requirements:
- Secret handling checks:
- Audit or logging checks:

### Dependency changes
- Install verification commands:
- Vulnerability audit commands:

## 7. Blocking Rules

- Commit must fail on:
  - unresolved lint errors
  - type or contract failures
  - broken script hygiene checks
  - merge-conflict markers, trailing whitespace, or oversized accidental files
  - gitleaks secret detection
- CI must fail on:
  - any blocking local gate that was bypassed
  - failing tests
  - build or packaging failures if the project ships artifacts
- Report-only by default:
  - dead-code reports
  - complexity trend reports
  - maintainability or coverage trend summaries
- `--no-verify` or equivalent bypass is allowed only for emergencies.
- Every bypass must be followed by:
  - written reason
  - remaining risk
  - follow-up task or issue

## 8. Complexity And Maintainability Budget

Use concrete numbers if the project has them. If not, start with a conservative baseline.

| Metric | Tool / rule | Threshold | Status | Notes |
|---|---|---|---|---|
| Cyclomatic complexity |  |  | blocking |  |
| Max branches per function |  |  | blocking |  |
| Max statements per function |  |  | blocking |  |
| Max arguments per function |  |  | blocking |  |
| Max returns per function |  |  | blocking |  |
| Dead-code confidence threshold |  |  | report-only |  |
| Maintainability index floor |  |  | report-only |  |

Refactoring rule:
- If a function or module repeatedly exceeds the budget, split responsibilities before adding more behavior.

> 비코드 프로젝트인 경우 이 섹션을 N/A로 표기한다.

## 9. Exception Register

- Prefer per-file or per-scope exceptions over global ignores.
- Prefer inline suppressions with rule IDs and reasons over silent blanket disables.
- Every long-lived exception should record:
  - rule ID
  - exact scope
  - why the exception exists
  - owner
  - review date
- `# noqa` 인라인 주석은 반드시 규칙 ID와 사유를 포함한다 (`# noqa: C901 — 사유`). bare `# noqa`는 금지.

| ID | Rule / check | Scope | Why allowed | Owner | Review date |
|---|---|---|---|---|---|
|  |  |  |  |  |  |

## 10. Standard Command Set

Keep the command names stable if possible so humans and AI can predict the workflow.

| Command | Purpose | When to run |
|---|---|---|
| `setup` | install dependencies and register local hooks | onboarding |
| `lint` | lint only, no mutation unless explicitly intended | while coding |
| `fix` | safe autofix for lint issues | quick cleanup |
| `format` | apply formatter | before review |
| `format-check` | verify formatting without edits | CI parity |
| `type-check` | run type or schema checks | before commit |
| `test` | run automated tests | after behavior changes |
| `check` | aggregate local validation | before commit |
| `smoke-check` | verify runtime reachability after deploy or ops changes | after deploy |
| `all` | full validation bundle | before PR / merge |

Project-specific command mapping:
- `setup`:
- `lint`:
- `fix`:
- `format`:
- `format-check`:
- `type-check`:
- `test`:
- `check`:
- `smoke-check`:
- `all`:

> 비코드 프로젝트인 경우 적용 가능한 명령만 매핑하고 나머지는 N/A로 표기한다.

## 11. Key Rotation 절차

시크릿이 노출되었을 때:

1. **즉시**: 해당 서비스에서 키 비활성화/재발급
2. **Git 정리**: `git rm --cached <파일>` + `.gitignore`에 패턴 추가
3. **히스토리 정리**: push된 적이 있다면 `git filter-repo` 또는 GitHub 지원 요청 검토
4. **환경변수 업데이트**: `.env` 파일 + `~/.zshrc` (Claude Code용)
5. **문서화**: 아래 이력 테이블에 사건 기록

### 로테이션 이력

| 날짜 | 토큰 | 위치 | 조치 |
|---|---|---|---|
|  |  |  |  |

## 12. Gap Register

인지하고 있으나 아직 미적용인 항목을 기록한다.

| ID | Gap | Severity | Notes |
|---|---|---|---|
|  |  |  |  |

## 13. Quick Audit 체크리스트

프로젝트 또는 새 기기에서 아래를 확인한다:

### 보안 체계
- [ ] CLAUDE.md에 Security Rules 블록이 있는가
- [ ] `scripts/secret-guard.sh` 존재 + 실행 권한 (`chmod +x`)
- [ ] `.claude/settings.local.json`에 PreToolUse hooks 설정
- [ ] `.claude/settings.local.json`에 평문 토큰 없음
- [ ] `.gitignore`에 `**/.env` 표준 패턴 있음
- [ ] `.env.example`에 실제 값이 아닌 플레이스홀더만 있음
- [ ] gitleaks 설치 + pre-commit 등록 (코드 프로젝트)
- [ ] 필요한 환경변수가 `~/.zshrc`에 설정됨

### 품질 체계
- [ ] 3-Layer 피드백 루프가 구성되어 있는가 (없는 Layer는 Gap Register에 기록)
- [ ] 변경 유형별 검증 명령이 매핑되어 있는가 (§6)
- [ ] Standard Command Set이 프로젝트에 맞게 매핑되어 있는가 (§10)
- [ ] 프로젝트별 검증 명령을 실행하여 통과 확인

### Git 연동
- [ ] `GIT_WORKFLOW.md`가 존재하는가 ([[03_Project Git Workflow]] 기반)
- [ ] `CLAUDE.md`에 Pre-commit Quality Gate 순서가 명시되어 있는가 (CODE_QUALITY → GIT_WORKFLOW)

## 14. Prompt To Paste

```text
Use this note as the code-quality and security contract for the project.

Instructions:
- Prefer fast local feedback first, then commit-time validation, then CI.
- Run the minimum validation for the touched scope before committing or pushing.
- Treat formatting as automated; spend review attention on correctness, contracts, regressions, and risk.
- Do not widen ignore rules or suppressions without recording the reason in the exception register.
- Keep report-only metrics visible, but do not silently convert them into blocking gates without updating this note.
- If an emergency requires bypassing a hook or gate, record why, what risk remains, and what follow-up closes the gap.
- When runtime or deployment behavior changes, require a smoke check in addition to static checks.
- NEVER read .env files — use .env.example for reference.
- NEVER include tokens in code, comments, settings, or commit messages.
- If a task requires an API key value, ask the user.

Be strict about verification, but keep the workflow fast enough that people will actually follow it.
```

## 15. Decision Log

> 프로젝트 수준의 중요 결정은 [[07_Decision Log]] 정본에도 등록한다.

| Decision | Why | Date | Notes |
|---|---|---|---|
|  |  |  |  |

## 16. Change History

| Date | Change |
|---|---|
|  |  |

## 17. Review Triggers

Update this note when:
- the toolchain changes
- blocking vs report-only gates change
- complexity budgets change
- new languages or runtimes are added
- deployment or smoke-check rules change
- security layers are added, removed, or weakened
- repeated exceptions suggest the policy is too strict, too weak, or outdated
- a secret exposure incident occurs
