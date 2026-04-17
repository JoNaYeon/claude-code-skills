# Claude Code Skills

Claude Code에서 사용하는 개인 **스킬** 및 **프로젝트 템플릿** 모음입니다.

---

## 네이밍 규칙

```
/{카테고리}_{서브카테고리}_{스킬-이름}
        ↑           ↑         ↑
        └─ `_`로 구분 ─┘       └─ `-`로 구분 (스킬 이름 내부)
```

예시:
- `/work_git_git-start`
- `/work_ai_project-skill-kickoff`
- `/daily_morning-briefing`
- `/misc_navigation_menu`

### 폴더 구조와 스킬 이름의 관계

```
work/git/work_git_git-start/SKILL.md
     ↑            ↑
     └─ 카테고리 경로 ─┘
                  └─ 스킬 폴더 이름 (= 슬래시 명령어)
```

- **폴더 경로**: `work/git/` (분류용, `-` 는 이름 내부 구분)
- **스킬 폴더 이름**: `work_git_git-start` (= 실제 `/` 명령어)

---

## 목차

- [스킬 목록](#스킬-목록)
- [템플릿](#템플릿)
- [슬래시 커맨드](#슬래시-커맨드)
- [설치하기](#설치하기-전역--모든-프로젝트에-적용)
- [새 스킬 만들기](#새-스킬-만들기)
- [폴더 구조](#폴더-구조)

---

## 스킬 목록

스킬은 용도에 따라 **업무용 / 일상용 / 기타** 로 구분됩니다.

---

## 💼 업무용 (`work/`)

### 🔀 Git (`work/git/`)
| 스킬 | 설명 |
|------|------|
| [`/work_git_git-start`](./work/git/work_git_git-start/SKILL.md) | 작업 전 레포 준비 및 브랜치 생성 |
| [`/work_git_git-finish`](./work/git/work_git_git-finish/SKILL.md) | 작업 후 커밋·푸시 및 GitHub Issue 등록 |
| [`/work_git_git-diff-summary`](./work/git/work_git_git-diff-summary/SKILL.md) | 이전 커밋과 현재 코드의 변경사항 요약 |
| [`/work_git_commit-message`](./work/git/work_git_commit-message/SKILL.md) | 변경사항 분석 후 Conventional Commits 메시지 생성 |
| [`/work_git_pr-creator`](./work/git/work_git_pr-creator/SKILL.md) | 변경사항 기반 PR 본문 자동 작성 및 생성 |
| [`/work_git_changelog`](./work/git/work_git_changelog/SKILL.md) | git 히스토리에서 버전별 CHANGELOG 생성 |
| [`/work_git_conflict-resolver`](./work/git/work_git_conflict-resolver/SKILL.md) | Merge/Rebase 충돌 분석 및 해결 제안 |

### 🖥️ Coding (`work/coding/`)
| 스킬 | 설명 |
|------|------|
| [`/work_coding_code-review`](./work/coding/work_coding_code-review/SKILL.md) | 코드 품질·보안·성능·가독성 체계적 리뷰 |
| [`/work_coding_refactor-guide`](./work/coding/work_coding_refactor-guide/SKILL.md) | 코드 스멜 탐지 및 리팩토링 제안 |
| [`/work_coding_debug-guide`](./work/coding/work_coding_debug-guide/SKILL.md) | 에러·스택 트레이스 분석 및 수정 (JS/Python/Go/Java) |
| [`/work_coding_security-audit`](./work/coding/work_coding_security-audit/SKILL.md) | OWASP 기준 보안 취약점 탐지 |
| [`/work_coding_dependency-audit`](./work/coding/work_coding_dependency-audit/SKILL.md) | 취약하거나 오래된 패키지 탐지 및 업데이트 |
| [`/work_coding_project-review`](./work/coding/work_coding_project-review/SKILL.md) | 프로젝트 전체 종합 리뷰 — 구조·DB·보안·함수·TODO·버그를 README로 생성 |
| [`/work_coding_web-scaffold`](./work/coding/work_coding_web-scaffold/SKILL.md) | 제목·역할·기능 입력 → Flask+JS 웹 프로젝트 자동 생성 |

### 📄 Docs (`work/docs/`)
| 스킬 | 설명 |
|------|------|
| [`/work_docs_api-docs`](./work/docs/work_docs_api-docs/SKILL.md) | 소스 코드 기반 API 문서 자동 생성 |
| [`/work_docs_code-explain`](./work/docs/work_docs_code-explain/SKILL.md) | 복잡한 코드를 쉽게 설명 (온보딩용) |
| [`/work_docs_readme-generator`](./work/docs/work_docs_readme-generator/SKILL.md) | 프로젝트 분석 후 README.md 자동 생성 |

### 🐳 DevOps (`work/devops/`)
| 스킬 | 설명 |
|------|------|
| [`/work_devops_dockerfile`](./work/devops/work_devops_dockerfile/SKILL.md) | Dockerfile 생성 및 베스트 프랙티스 기반 리뷰 |

### 🧪 Testing (`work/testing/`)
| 스킬 | 설명 |
|------|------|
| [`/work_testing_test-generator`](./work/testing/work_testing_test-generator/SKILL.md) | 함수/모듈에 대한 단위 테스트 자동 생성 |

### 🤖 AI / PM (`work/ai/`)
프로젝트에 AI를 세팅·평가·운영하기 위한 PM 워크플로우 스킬입니다.

| 스킬 | 설명 |
|------|------|
| [`/work_ai_project-skill-kickoff`](./work/ai/work_ai_project-skill-kickoff/SKILL.md) | 새 프로젝트 시작 시 AI 스킬 컨텍스트 세팅 |
| [`/work_ai_project-archetype-selector`](./work/ai/work_ai_project-archetype-selector/SKILL.md) | 프로젝트 아키타입 분류 & 최적 스킬 추천 |
| [`/work_ai_skill-evaluation`](./work/ai/work_ai_skill-evaluation/SKILL.md) | 외부 스킬 도입 전 신뢰성·적합성 평가 |
| [`/work_ai_custom-local-skill-draft`](./work/ai/work_ai_custom-local-skill-draft/SKILL.md) | 프로젝트 전용 커스텀 로컬 스킬 초안 작성 |
| [`/work_ai_project-git-workflow`](./work/ai/work_ai_project-git-workflow/SKILL.md) | 프로젝트 Git 워크플로우 정의·문서화 |
| [`/work_ai_project-code-quality-security`](./work/ai/work_ai_project-code-quality-security/SKILL.md) | 코드 품질 & 보안 기준 설정 |
| [`/work_ai_project-orchestrator-session-start`](./work/ai/work_ai_project-orchestrator-session-start/SKILL.md) | 오케스트레이터 세션 시작 & 컨텍스트 로딩 |
| [`/work_ai_pm-planning-workflow`](./work/ai/work_ai_pm-planning-workflow/SKILL.md) | PM 기획 워크플로우 (기능 브리프, UX, 백로그) |
| [`/work_ai_mission-control`](./work/ai/work_ai_mission-control/SKILL.md) | 프로젝트 관제 센터 (태스크, 백로그, 대시보드) |

### 📤 Reporting (`work/reporting/`)
| 스킬 | 설명 |
|------|------|
| [`/work_reporting_daily-report`](./work/reporting/work_reporting_daily-report/SKILL.md) | GitHub Issues 분류·요약 후 Slack 채널에 데일리 리포트 업로드 |

---

## 📚 Study (`study/`)

개인 학습/기술 습득 관련 스킬입니다.

| 스킬 | 설명 |
|------|------|
| [`/study_engineering-note`](./study/study_engineering-note/SKILL.md) | 대화 중 배운 기술/엔지니어링 개념을 Notion 엔지니어링 문서에 구조화해서 페이지로 정리 |
| [`/study_memo`](./study/study_memo/SKILL.md) | 파일·링크·텍스트를 Notion MEMO DB에 속성(idea/news/book/note/work/ect)별 맞춤 템플릿으로 정리 |

---

## 🌅 일상용 (`daily/`)

| 스킬 | 설명 |
|------|------|
| [`/daily_morning-briefing`](./daily/daily_morning-briefing/SKILL.md) | 아침 브리핑 — Google 캘린더·Tasks·뉴스·Gmail 통합 요약 |

---

## 🧰 기타 (`misc/`)

### 🗂 Navigation (`misc/navigation/`)
스킬이 너무 많을 때 카테고리별로 묶어서 보여주는 라우터 스킬입니다.

| 스킬 | 설명 |
|------|------|
| [`/misc_navigation_menu`](./misc/navigation/misc_navigation_menu/SKILL.md) | 전체 스킬 카테고리 통합 메뉴 |
| [`/misc_navigation_ai-menu`](./misc/navigation/misc_navigation_ai-menu/SKILL.md) | AI 스킬 카테고리 서브메뉴 |
| [`/misc_navigation_git-menu`](./misc/navigation/misc_navigation_git-menu/SKILL.md) | Git 스킬 카테고리 서브메뉴 |
| [`/misc_navigation_coding-menu`](./misc/navigation/misc_navigation_coding-menu/SKILL.md) | Coding 스킬 카테고리 서브메뉴 |
| [`/misc_navigation_docs-menu`](./misc/navigation/misc_navigation_docs-menu/SKILL.md) | Documentation 스킬 카테고리 서브메뉴 |
| [`/misc_navigation_devops-menu`](./misc/navigation/misc_navigation_devops-menu/SKILL.md) | DevOps 스킬 카테고리 서브메뉴 |

---

## 슬래시 커맨드

`.claude/commands/` 에 위치한 슬래시 커맨드입니다. (스킬과 별개로 기존에 존재)

### 📥 Intake (`/intake/*`)
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

`_template/` 에 위치한 프로젝트·노트 템플릿입니다.

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

### 🔧 스킬 보일러플레이트 (`_template/skill-name/`)

새 스킬을 만들 때 참고할 수 있는 파일 골격입니다.

---

## 설치하기 (전역 — 모든 프로젝트에 적용)

`~/.claude/skills/` 에 설치하면 **모든 프로젝트에서 자동으로 스킬이 인식**됩니다.

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
bash install.sh
```

---

## 새 스킬 만들기

1. **카테고리 경로 선택 및 네이밍**
   - 업무용: `work/<subcategory>/work_<subcategory>_<name-with-dashes>/SKILL.md`
   - 일상용: `daily/daily_<name-with-dashes>/SKILL.md`
   - 기타: `misc/<subcategory>/misc_<subcategory>_<name-with-dashes>/SKILL.md`

2. **폴더 + SKILL.md 생성**
   ```bash
   mkdir -p work/coding/work_coding_my-new-skill
   cp _template/skill-name/SKILL.md work/coding/work_coding_my-new-skill/SKILL.md
   ```

3. **SKILL.md 편집**
   ```markdown
   ---
   name: work_coding_my-new-skill
   description: "커맨드 설명 (트리거 키워드 포함)"
   ---

   # 커맨드 이름

   ## 지침
   ...
   ```

4. **README에 한 줄 추가** (해당 카테고리 테이블에)

5. **커밋 & 푸시**

---

## 폴더 구조

```
claude-code-skills/
├── work/                        # 업무용 스킬
│   ├── ai/                      #   work_ai_*  (9)
│   ├── coding/                  #   work_coding_*  (7)
│   ├── docs/                    #   work_docs_*  (3)
│   ├── git/                     #   work_git_*  (7)
│   ├── devops/                  #   work_devops_*  (1)
│   ├── testing/                 #   work_testing_*  (1)
│   └── reporting/               #   work_reporting_*  (1)
├── study/                       # 학습용 스킬 (study_*)
├── daily/                       # 일상용 스킬 (daily_*)
├── misc/
│   └── navigation/              # 메뉴 라우터 (misc_navigation_*)
├── .claude/commands/            # 기존 슬래시 커맨드
│   ├── intake/                  #   /intake/*
│   └── research/                #   /research/*
├── _template/                   # 템플릿 모음
│   ├── notes/                   #   Obsidian 노트 템플릿
│   ├── project-pack/            #   PM 라이프사이클 문서
│   └── skill-name/              #   스킬 보일러플레이트
├── install.sh                   # 전역 설치 스크립트
├── LICENSE
└── README.md
```

---

## License

MIT
