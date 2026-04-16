# Claude Code Skills

Claude Code에서 사용하는 개인 스킬, 커맨드, 프로젝트 템플릿 모음입니다.

---

## 목차

- [스킬 목록](#스킬-목록)
- [슬래시 커맨드](#슬래시-커맨드)
- [템플릿](#템플릿)
- [설치하기](#설치하기-전역--모든-프로젝트에-적용)
- [새 스킬 만들기](#새-스킬-만들기)
- [폴더 구조](#폴더-구조)

---

## 스킬 목록

### 🔀 Git
| 스킬 | 설명 |
|------|------|
| [git-diff-summary](./git/git-diff-summary/SKILL.md) | 이전 커밋과 현재 코드의 변경사항 요약 |
| [git-start](./git/git-start/SKILL.md) | 작업 전 레포 준비 및 브랜치 생성 |
| [git-finish](./git/git-finish/SKILL.md) | 작업 후 커밋·푸시 및 GitHub Issue 등록 |
| [pr-creator](./git/pr-creator/SKILL.md) | 변경사항 기반 PR 본문 자동 작성 및 생성 |
| [changelog](./git/changelog/SKILL.md) | git 히스토리에서 버전별 CHANGELOG 생성 |
| [conflict-resolver](./git/conflict-resolver/SKILL.md) | Merge/Rebase 충돌 분석 및 해결 제안 |

### 🖥️ Coding
| 스킬 | 설명 |
|------|------|
| [code-review](./coding/code-review/SKILL.md) | 코드 품질·보안·성능·가독성 체계적 리뷰 |
| [refactor-guide](./coding/refactor-guide/SKILL.md) | 코드 스멜 탐지 및 리팩토링 제안 |
| [debug-guide](./coding/debug-guide/SKILL.md) | 에러·스택 트레이스 분석 및 수정 (JS/Python/Go/Java) |
| [security-audit](./coding/security-audit/SKILL.md) | OWASP 기준 보안 취약점 탐지 |
| [dependency-audit](./coding/dependency-audit/SKILL.md) | 취약하거나 오래된 패키지 탐지 및 업데이트 |

### 📄 Documentation
| 스킬 | 설명 |
|------|------|
| [api-docs](./documentation/api-docs/SKILL.md) | 소스 코드 기반 API 문서 자동 생성 |
| [code-explain](./documentation/code-explain/SKILL.md) | 복잡한 코드를 쉽게 설명 (온보딩용) |
| [readme-generator](./documentation/readme-generator/SKILL.md) | 프로젝트 분석 후 README.md 자동 생성 |

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

## 슬래시 커맨드

`.claude/commands/` 에 위치한 슬래시 커맨드입니다.

### 📥 Intake (`/intake/*`)

콘텐츠를 비판적으로 검증한 뒤 구조화된 knowledge 노트로 저장하는 인제스트 워크플로우입니다.

| 커맨드 | 설명 |
|--------|------|
| [`/intake/article`](./.claude/commands/intake/article.md) | 기사·블로그·X 스레드를 4단계 비판적 검증 후 knowledge 노트로 저장 |
| [`/intake/book`](./.claude/commands/intake/book.md) | 책 내용 정리 — 4단계 검증 + 저자 프레임워크 추출 + 내 상황 적용 |
| [`/intake/pdf`](./.claude/commands/intake/pdf.md) | inbox-pdf/ 폴더의 PDF를 읽고 4단계 검증 후 knowledge 노트로 저장 |
| [`/intake/youtube`](./.claude/commands/intake/youtube.md) | 유튜브 영상 자막 추출 후 [2차요약] 태그와 함께 검증 |
| [`/intake/verify`](./.claude/commands/intake/verify.md) | 특정 주장이나 기존 노트에 대해 4단계 비판적 검증을 단독 실행 |

### 🔍 Research (`/research/*`)

| 커맨드 | 설명 |
|--------|------|
| [`/research/web`](./.claude/commands/research/web.md) | 웹 검색 기반 리서치 — 복수 소스 교차 검증 + 확신도 표기 |

---

## 템플릿

`_template/` 에 위치한 프로젝트·노트·AI 스킬 템플릿입니다.

### 🤖 AI 스킬 템플릿 (`_template/ai/`)

프로젝트에 AI를 세팅하기 위한 단계별 워크플로우 문서입니다.

| # | 템플릿 | 설명 |
|---|--------|------|
| 00 | [Project Skill Kickoff](./_template/ai/00_Project%20Skill%20Kickoff.md) | 프로젝트 스냅샷 + 기술/도메인 컨텍스트 정리 |
| 01 | [Project Archetype Selector](./_template/ai/01_Project%20Archetype%20Selector.md) | 프로젝트 아키타입(유형) 선택 및 반복 작업 식별 |
| 01 | [Skill Evaluation](./_template/ai/01_Skill%20Evaluation.md) | 외부 스킬 신뢰성·호환성 평가 및 도입 판단 |
| 02 | [Custom Local Skill Draft](./_template/ai/02_Custom%20Local%20Skill%20Draft.md) | 로컬 커스텀 스킬 직접 설계 드래프트 |
| 03 | [Project Git Workflow](./_template/ai/03_Project%20Git%20Workflow.md) | AI+사람 공용 브랜치·커밋·배포 규칙 정의 |
| 04 | [Code Quality And Security](./_template/ai/04_Project%20Code%20Quality%20And%20Security.md) | 코드 품질 게이트 + AI 보안 방어 체계 통합 정의 |
| 05 | [Orchestrator Session Start](./_template/ai/05_Project%20Orchestrator%20Session%20Start.md) | 세션 시작 시 최소 컨텍스트 제공 (디바이스 무관) |
| 06 | [PM Planning Workflow](./_template/ai/06_PM%20Planning%20Workflow.md) | 기획 논의 → 기술문서·디자인 반영까지 PM 워크플로우 |
| 08 | [Mission Control Skill](./_template/ai/08_Mission%20Control%20Skill.md) | 과업 관제센터 — 백로그 관리, 회의록 인제스트, 대시보드 |

### 📝 노트 템플릿 (`_template/notes/`)

Obsidian Brain Vault용 노트 템플릿입니다. [상세 안내](./_template/notes/README.md)

| # | 템플릿 | 설명 |
|---|--------|------|
| 00 | [Knowledge Note](./_template/notes/00_Knowledge%20Note.md) | 검증된 지식 구조화 저장 (출처·검증 상태·반대 시나리오 포함) |
| 01 | [Scrap](./_template/notes/01_Scrap.md) | 빠른 캡처용 스크랩 — 원문 발췌 후 추후 triage |
| 02 | [Daily Log](./_template/notes/02_Daily%20Log.md) | 일일 로그 — 계획·캡처·결정·성과·미결 사항 |
| 03 | [Taste Note](./_template/notes/03_Taste%20Note.md) | 콘텐츠 감상 기록 (영화, 책, 음악 등) |
| 04 | [Idea](./_template/notes/04_Idea.md) | 아이디어 시드 — 문제·인사이트·솔루션 방향 구조화 |
| 05 | [Topic](./_template/notes/05_Topic.md) | 관심 주제 추적 — 핵심 질문과 현재 가설(thesis) 정리 |

### 📋 프로젝트 팩 템플릿 (`_template/project-pack/`)

프로젝트 PM 라이프사이클 전체를 커버하는 문서 템플릿입니다. [상세 안내](./_template/project-pack/README.md)

| # | 템플릿 | 설명 |
|---|--------|------|
| 00 | [Project Context](./_template/project-pack/00_Project%20Context.md) | 프로젝트 요약·목표·현재 단계·제약사항 정의 |
| 01 | [Working Agreement](./_template/project-pack/01_Working%20Agreement.md) | AI-사람 간 응답 계약·읽기 순서·승격 규칙 |
| 02 | [Requirement Intake](./_template/project-pack/02_Requirement%20Intake.md) | 요구사항 구조화 — 문제·기대 결과·범위 정리 |
| 03 | [PRD](./_template/project-pack/03_PRD.md) | 제품 요구사항 문서 — 기능 전체의 수락 기준 정의 |
| 03-1 | [Feature Brief](./_template/project-pack/03-1_Feature%20Brief.md) | UX 중심 개별 기능 기획서 — 배경·화면 컨텍스트·요구사항 |
| 04 | [Scope Options](./_template/project-pack/04_Scope%20Options.md) | Minimum / Standard / Stretch 3단계 범위 옵션 |
| 05 | [Prototype Brief](./_template/project-pack/05_Prototype%20Brief.md) | 프로토타입이 증명할 것·데모 플로우·미검증 질문 정의 |
| 06 | [Prototype Review](./_template/project-pack/06_Prototype%20Review.md) | 프로토타입 결과 평가 — 일치/누락/모호 판단 |
| 07 | [Decision Log](./_template/project-pack/07_Decision%20Log.md) | 의사결정 추적 (ID·날짜·상태·근거) |
| 08 | [Task Item](./_template/project-pack/08_Task%20Item.md) | 개별 태스크 — 근거·소유자·우선순위·Todoist 연동 |
| 09 | [Batch Run](./_template/project-pack/09_Batch%20Run.md) | 오케스트레이터 배치 실행 — 태스크 보드·브랜치 정보 |

### 🔧 스킬 보일러플레이트 (`_template/skill-name/`)

새 스킬을 만들 때 복사해서 사용하는 기본 골격입니다.

| 파일 | 설명 |
|------|------|
| [SKILL.md](./_template/skill-name/SKILL.md) | YAML frontmatter + 마크다운 본문 보일러플레이트 |

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
├── .claude/commands/       # 슬래시 커맨드
│   ├── intake/             #   콘텐츠 인제스트 (article, book, pdf, youtube, verify)
│   └── research/           #   리서치 (web)
├── _template/              # 템플릿 모음
│   ├── ai/                 #   AI 스킬 세팅 워크플로우 (00~08)
│   ├── notes/              #   Obsidian 노트 템플릿 (knowledge, scrap, daily 등)
│   ├── project-pack/       #   PM 라이프사이클 문서 (context → PRD → task → batch)
│   └── skill-name/         #   새 스킬 생성용 보일러플레이트
├── coding/                 # 코딩 스킬 (code-review, refactor, debug, security, deps)
├── documentation/          # 문서화 스킬 (api-docs, code-explain, readme)
├── git/                    # Git 워크플로우 스킬 (start, finish, diff, PR, changelog, conflict)
├── productivity/           # 생산성 스킬 (commit-message)
├── testing/                # 테스트 스킬 (test-generator)
├── devops/                 # DevOps 스킬 (dockerfile)
├── install.sh              # 전역 설치 스크립트
├── LICENSE                 # MIT
└── README.md
```

---

## License

MIT
