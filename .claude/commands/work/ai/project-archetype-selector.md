---
description: "Use this skill to identify a project's archetype and select the most relevant skills. Triggers on: 'select archetype', 'project type', 'what kind of project', 'choose skills for project', '프로젝트 아키타입', '프로젝트 유형 선택'."
---


# Project Archetype Selector: {{title}}

## 1. This Project Feels Most Like

프로젝트의 성격을 아키타입으로 분류합니다. 복수 선택 가능.

- Primary archetype: <!-- 아래 목록에서 선택 -->
- Secondary archetype:
- Why these fit:

**아키타입 목록**:
| 아키타입 | 설명 | 대표적 반복 작업 |
|----------|------|------------------|
| **Web App (Full-stack)** | 프론트+백엔드 웹 서비스 | 컴포넌트 생성, API 연동, DB 마이그레이션 |
| **API Service** | REST/GraphQL API 서버 | 엔드포인트 추가, 스키마 변경, 인증 처리 |
| **Data Pipeline** | ETL, 배치, 데이터 처리 | 파이프라인 추가, 스키마 변환, 모니터링 |
| **CLI Tool** | 터미널 도구, 스크립트 | 커맨드 추가, 옵션 파싱, 출력 포맷팅 |
| **Library / SDK** | 재사용 패키지 | API 설계, 테스트, 문서화, 버전 관리 |
| **Mobile App** | iOS/Android/Flutter 등 | 화면 추가, 네비게이션, 상태관리 |
| **Infra / DevOps** | IaC, CI/CD, 모니터링 | 리소스 프로비저닝, 파이프라인 수정 |
| **ML / AI** | 모델 학습, 추론 서비스 | 실험 추적, 데이터 전처리, 모델 배포 |
| **Content / Docs** | 문서화, 블로그, 지식관리 | 문서 작성, 템플릿 관리, 검수 |

Reference:
- [[Project Archetype Skill Map]]

## 2. Project Snapshot

> 이 섹션의 값은 [[00_Project Context]] 에서 가져온다.

- Project: <!-- 프로젝트명 -->
- Goal: <!-- 한 줄 목표 -->
- Repo / folder: <!-- 레포 URL 또는 로컬 경로 -->
- Stage: <!-- planning / active-dev / maintenance / sunset -->
- Main deliverable: <!-- 최종 산출물 (웹사이트, API, 앱, 라이브러리 등) -->

## 3. Real Repeated Tasks

직접 경험한 반복 작업을 구체적으로 적습니다. 이것이 스킬 선택의 핵심 근거입니다.

- **What do I keep doing?**
  <!-- 예: 매번 새 API 엔드포인트를 만들 때 라우터+컨트롤러+서비스+테스트를 4개 파일에 걸쳐 작성 -->
  -
- **What is slow or annoying?**
  <!-- 예: DB 마이그레이션 SQL을 수동으로 작성하고 타입 정의를 맞추는 작업 -->
  -
- **What do I want the model to do better?**
  <!-- 예: 기존 코드 패턴을 더 정확하게 따르면서 보일러플레이트를 자동 생성 -->
  -

## 4. Constraints

프로젝트의 기술적·환경적 제약을 기록합니다. 스킬 호환성 판단에 사용됩니다.

- Stack: <!-- 예: Node.js 20 + Express + PostgreSQL + React 18 -->
- Tools already in use: <!-- 예: ESLint, Prettier, Jest, Docker -->
- Risky actions to avoid: <!-- 예: 프로덕션 DB에 직접 쿼리 금지, 메인 브랜치 직접 push 금지 -->
- Credentials / external systems: <!-- 예: AWS S3 (업로드), Slack API (알림), 폐쇄망 내부 미러 -->
- Time budget: <!-- 예: 스킬 세팅에 1시간 이내 -->

## 5. What I Want Recommended

- Number of skill candidates: <!-- 3~5개 권장, 너무 많으면 선택 피로 -->
- Prefer official / community / mixed: <!-- official-first / community-ok / mixed -->
- Okay to suggest local custom skill?: <!-- yes / no -->
- Exclude anything?: <!-- 예: Copilot 관련 스킬 제외, 유료 API 필요한 스킬 제외 -->

## 6. Paste Prompt
```text
Use this note and [[Project Archetype Skill Map]] as the context for skill selection.

First identify the project's primary and secondary archetypes.
Then inspect the codebase or working docs and recommend only the smallest useful shortlist.

Requirements:
- Prefer official / high-trust skills first
- Keep the shortlist small (3-5 candidates max)
- Separate: install now / optional later / skip or risky
- Explain why each recommendation matches this project's repeated tasks
- If no strong fit exists, suggest a small local custom skill instead
- Consider the constraints listed in section 4

Keep the answer practical and concise.
```

## 7. Skill Selection Log

선택 결과를 기록합니다.

| Skill | Why it matched | Decision | Notes |
|---|---|---|---|
| <!-- 스킬명 --> | <!-- 3번 반복 작업과의 연결 --> | candidate / adopted / skipped | <!-- 추가 메모 --> |
| | | | |
| | | | |
