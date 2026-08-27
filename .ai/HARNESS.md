# AI 세팅 — claude-code-skills

<!-- `init-project.sh --portable` 이 생성한다. <PLACEHOLDER> 는 그 시점의 선언에서 채워진다.
     이 파일은 커밋된다 — 하네스에 접근할 수 없는 계정·머신·AI 도구도 이것만 보고 환경을
     재현할 수 있어야 한다. 머신 경로·토큰·조직 실값은 쓰지 않는다. -->

이 레포로 작업하려면 아래를 갖춘다.

| 항목 | 값 |
|---|---|
| 하네스 레포 | `https://github.com/JoNaYeon/ai-ops-harness.git` |
| 요구 ref | `main` |
| 조직 · 역할 | `none` · `none` |
| 필요한 MCP 서버 | `(미설정)` |
| 규칙 미러 | 레포 루트 `AGENTS.md` (생성물 — 손으로 고치지 않는다) |

## 부트스트랩

```bash
bash .ai/bootstrap.sh
```

PowerShell 이면 `.ai/bootstrap.ps1`. 하네스를 클론하고 전역 설치를 얹은 뒤 이 레포의
조직·역할을 선언하고 커밋 게이트를 건다. 여러 번 돌려도 안전하다.

## 하네스 없이 작업할 때

하네스 클론에 접근할 수 없으면(권한이 없거나 웹 세션이거나) 다음까지는 여전히 유효하다.

- **레포 루트 `AGENTS.md`** — 규칙의 플랫폼 중립 미러. 대부분의 AI 도구가 이 이름을 읽는다.
- **`.ai/handoff/`** — 마지막 세션이 어디까지 했는지. 이 파일만 읽고 이어갈 수 있게 쓴다.
- **`.git/hooks` 커밋 게이트** — bootstrap 이 걸어 두면 어떤 도구가 커밋하든 돈다.

작동하지 않는 것: 실행 시점 차단 훅과 스킬은 Claude Code 전용이다. 다른 도구에서는 규칙
준수가 `AGENTS.md` 해석에 의존하며 기계적으로 강제되지 않는다.

## 세션을 마칠 때

`.ai/handoff/YYYY-MM-DD.md` 를 남긴다 (양식: `.ai/handoff/_TEMPLATE.md`).
민감정보는 담지 않는다 — 이 파일은 커밋되어 다른 계정에게도 보인다.
