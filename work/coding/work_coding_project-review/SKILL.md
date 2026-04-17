---
name: work_coding_project-review
description: "Use this skill when the user wants a comprehensive project review document, onboarding documentation for a codebase, or a full project analysis written for newcomers. This is NOT a simple code review — it produces a multi-section README-level document covering architecture, DB, security, functions, TODOs, and bugs. Triggers on: 'project review', 'review the whole project', 'write project documentation', 'onboarding docs', 'analyze this repo', '프로젝트 리뷰해줘', '프로젝트 분석해줘', '코드 문서화해줘', '이 레포 정리해줘', '온보딩 문서 만들어줘', '프로젝트 정리해줘', '전체 코드 리뷰'."
---

# Project Review — 종합 프로젝트 리뷰 문서 생성

## 목적
프로젝트의 전체 코드를 **처음 읽는 개발자의 시선**으로 분석하여, 구조·DB·보안·함수·TODO·버그를 망라하는 종합 리뷰 문서를 생성하고 해당 레포의 README로 업로드합니다.

## 관점
> "내가 내일 이 프로젝트에 투입된다면, 이 문서 하나만 읽고 바로 작업을 시작할 수 있어야 한다."

모든 섹션을 이 관점에서 작성합니다. 내부자만 아는 용어, 암묵적 전제, 숨은 의존성을 전부 밝힙니다.

---

## 지침

### Phase 1 — 프로젝트 전체 탐색

#### 1-1. 프로젝트 메타 정보 수집
```bash
# 폴더 구조 파악
find . -maxdepth 3 -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/venv/*' -not -path '*/__pycache__/*' | head -100

# 의존성 확인
cat package.json 2>/dev/null || cat requirements.txt 2>/dev/null || cat go.mod 2>/dev/null || cat pom.xml 2>/dev/null || cat Cargo.toml 2>/dev/null

# 환경 설정 파일
cat .env.example 2>/dev/null || cat .env.sample 2>/dev/null
cat docker-compose.yml 2>/dev/null
cat Dockerfile 2>/dev/null

# git 히스토리로 프로젝트 맥락 파악
git log --oneline -20
git remote -v
```

#### 1-2. 핵심 파일 전수 읽기
- **진입점** (main, index, app, server 등) 먼저 읽습니다.
- **라우터/컨트롤러** → **서비스/비즈니스 로직** → **모델/DB** → **유틸/헬퍼** 순서로 읽습니다.
- **설정 파일** (config, env, constants) 을 반드시 읽습니다.
- 모든 파일을 빠짐없이 읽되, node_modules/venv 등 의존성 폴더는 제외합니다.

#### 1-3. 사용자 확인
사용자에게 묻습니다:
> 이 프로젝트에 대해 반드시 알아야 할 특수 사항이 있나요?
> (예: 폐쇄망 환경, 특정 인증 체계, 레거시 제약, 외부 연동 시스템 등)

---

### Phase 2 — 섹션별 분석 및 작성

아래 8개 섹션을 순서대로 작성합니다.

---

#### 📌 섹션 1: 프로젝트 개요 (Project Overview)

- 프로젝트가 **무엇**을 하는지 1~3문장으로 요약
- 사용 기술 스택 (언어, 프레임워크, DB, 인프라)
- 실행 환경 요약 (로컬 / Docker / 클라우드 / 폐쇄망 등)
- 주요 외부 의존성 및 연동 시스템

---

#### 📌 섹션 2: 필수 사전 지식 (Must-Know Before You Start)

처음 투입된 개발자가 **코드를 읽기 전에** 반드시 알아야 할 사항을 정리합니다:
- 배포 환경 특수성 (폐쇄망, VPN, 특수 네트워크 등)
- 인증/인가 방식 (SSO, LDAP, JWT, 세션 등)
- 데이터 흐름의 특이점 (배치 처리, 이벤트 드리븐, 큐 등)
- 코드 컨벤션 또는 아키텍처 패턴 (MVC, 클린 아키텍처, 모노레포 등)
- 개발 환경 세팅 시 주의사항 (특수 환경변수, 인증서, 프록시 등)
- 레거시 또는 기술 부채 관련 주의 사항

```markdown
> ⚠️ **이 프로젝트는 폐쇄망에서 운영됩니다.**
> npm/pip 등 외부 패키지 매니저에 직접 접근이 불가능하며,
> 내부 미러 서버(nexus.internal.corp)를 통해 의존성을 관리합니다.
```

---

#### 📌 섹션 3: 아키텍처 & 폴더 구조 (Architecture Overview)

한 눈에 전체 구조를 파악할 수 있는 요약 페이지입니다.

**3-1. 폴더 구조 트리**
```
src/
├── controllers/    # HTTP 요청 핸들링
├── services/       # 비즈니스 로직
├── models/         # DB 모델 / 엔티티
├── middlewares/    # 인증, 로깅 등 미들웨어
├── routes/         # 라우트 정의
├── utils/          # 유틸리티 함수
└── config/         # 환경설정
```
각 폴더 옆에 **한 줄 설명**을 반드시 붙입니다.

**3-2. 요청 흐름 다이어그램** (텍스트 기반)
```
Client → [Nginx/LB] → [Middleware: Auth, Logger]
       → [Router] → [Controller] → [Service] → [Model/DB]
       → Response
```

**3-3. 주요 모듈 간 의존 관계**
어떤 모듈이 어떤 모듈을 호출하는지 화살표로 표현합니다.

---

#### 📌 섹션 4: DB 구조 (Database Schema & Connections)

- 사용 DBMS (MySQL, PostgreSQL, MongoDB, Redis 등)
- 연결 설정 위치 및 방식 (환경변수, connection pool, ORM 설정)
- **주요 테이블/컬렉션 목록** — 각각 한 줄 설명
- 테이블 간 관계 (1:N, N:M 등)
- 마이그레이션/시드 파일 위치 및 실행 방법
- 인덱스, 트리거, 프로시저가 있으면 기록
- Redis/캐시 사용 현황

```markdown
| 테이블 | 설명 | 주요 관계 |
|--------|------|-----------|
| users | 사용자 계정 | → user_roles (1:N) |
| orders | 주문 내역 | → users (N:1), → order_items (1:N) |
```

---

#### 📌 섹션 5: 서버 구조 & 연결 (Server Architecture & Connections)

- 서버 실행 방식 (단일 프로세스, 클러스터, PM2, Docker 등)
- 포트 번호 및 프로토콜 (HTTP, HTTPS, WebSocket, gRPC 등)
- 외부 API 연동 목록 (URL, 인증 방식, 타임아웃 등)
- 파일 업로드/저장 경로 (로컬, S3, NAS 등)
- 로깅 구조 (로그 위치, 레벨, 로테이션)
- CORS, 프록시, 리버스 프록시 설정
- 환경별 설정 차이 (dev / staging / production)

---

#### 📌 섹션 6: 주요 함수 & 변수 레퍼런스 (Code Reference)

**파일별로** 주요 함수와 변수를 정리합니다.

```markdown
### `src/services/authService.js`

| 함수/변수 | 타입 | 설명 |
|-----------|------|------|
| `login(email, password)` | async function | 이메일+비밀번호로 로그인, JWT 토큰 반환 |
| `verifyToken(token)` | function | JWT 토큰 검증, 디코딩된 payload 반환 |
| `TOKEN_EXPIRY` | const (string) | 토큰 만료 시간 (기본: '24h') |
| `refreshToken(oldToken)` | async function | 만료 직전 토큰 갱신 |
```

작성 기준:
- 모든 export 함수는 반드시 기록
- private/내부 함수는 복잡한 로직이 있는 경우에만 기록
- 매개변수와 반환값의 타입을 명시
- 사이드 이펙트(DB 쓰기, 외부 API 호출 등)가 있으면 표기

---

#### 📌 섹션 7: TODO & 기술 부채 (TODOs & Tech Debt)

코드 내 주석에서 수집한 TODO, FIXME, HACK, XXX, OPTIMIZE 등을 정리합니다.

```bash
# 코드 내 TODO/FIXME 수집
grep -rn "TODO\|FIXME\|HACK\|XXX\|OPTIMIZE\|TEMP\|DEPRECATED" --include="*.{js,ts,py,java,go,rs,jsx,tsx,vue}" .
```

```markdown
| # | 위치 | 유형 | 내용 | 우선순위 |
|---|------|------|------|----------|
| 1 | src/auth.js:42 | TODO | 토큰 갱신 로직 구현 필요 | 🔴 High |
| 2 | src/utils.js:15 | FIXME | 날짜 파싱에서 timezone 미처리 | 🟡 Medium |
| 3 | src/db.js:88 | HACK | 임시로 하드코딩된 connection string | 🔴 High |
```

우선순위 판단 기준:
- **🔴 High**: 보안, 데이터 손실, 서비스 중단 가능성
- **🟡 Medium**: 기능 누락, 성능 저하
- **🟢 Low**: 코드 스타일, 리팩토링 희망사항

---

#### 📌 섹션 8: 보안 & 버그 리포트 (Security & Bug Report)

##### 보안 점검
OWASP Top 10 기준으로 점검합니다:
- **Injection**: SQL/NoSQL/Command injection 가능성
- **인증/세션**: 하드코딩된 시크릿, 취약한 해시, 세션 고정
- **XSS**: 사용자 입력의 미이스케이프 출력
- **민감 데이터 노출**: 로그에 비밀번호/토큰 기록, .env 커밋 여부
- **접근 제어**: 권한 검증 누락된 엔드포인트
- **의존성**: 알려진 CVE가 있는 패키지

##### 버그 / 잠재적 문제
코드 분석 중 발견한 버그 또는 잠재적 문제를 정리합니다:
- 에러 핸들링 누락
- race condition 가능성
- 메모리 누수 패턴
- 무한 루프 가능성
- 미처리된 Promise rejection
- 잘못된 타입 캐스팅

```markdown
| # | 심각도 | 위치 | 유형 | 설명 | 권장 수정 |
|---|--------|------|------|------|-----------|
| 1 | 🔴 Critical | src/db.js:23 | 보안 | SQL 인젝션 가능 | Prepared statement 사용 |
| 2 | 🔴 Critical | config.js:5 | 보안 | DB 비밀번호 하드코딩 | 환경변수로 이동 |
| 3 | 🟡 Warning | src/api.js:67 | 버그 | try-catch 없이 외부 API 호출 | 에러 핸들링 추가 |
```

---

### Phase 3 — README 생성 및 업로드

#### 3-1. 문서 조합
위 8개 섹션을 하나의 README.md로 조합합니다.

문서 최상단에 다음을 포함합니다:
```markdown
# [프로젝트명] — 프로젝트 리뷰 문서

> 📅 리뷰 일자: YYYY-MM-DD
> 📌 리뷰 범위: 전체 코드베이스
> 🎯 대상 독자: 이 프로젝트에 처음 투입되는 개발자

---

## 목차
1. [프로젝트 개요](#프로젝트-개요)
2. [필수 사전 지식](#필수-사전-지식)
3. [아키텍처 & 폴더 구조](#아키텍처--폴더-구조)
4. [DB 구조](#db-구조)
5. [서버 구조 & 연결](#서버-구조--연결)
6. [주요 함수 & 변수 레퍼런스](#주요-함수--변수-레퍼런스)
7. [TODO & 기술 부채](#todo--기술-부채)
8. [보안 & 버그 리포트](#보안--버그-리포트)
```

#### 3-2. 사용자 확인
완성된 문서를 사용자에게 보여주고 확인합니다:
> 이 리뷰 문서를 레포의 README.md로 업로드할까요?
> - **README.md로 교체** → 기존 README를 백업 후 교체
> - **REVIEW.md로 별도 저장** → 기존 README 유지, 리뷰 문서를 별도 파일로
> - **docs/REVIEW.md** → docs 폴더 하위에 저장

#### 3-3. 업로드
사용자 선택에 따라 파일을 생성하고 커밋·푸시합니다.

```bash
# 기존 README 백업 (교체 선택 시)
cp README.md README.backup.md 2>/dev/null

# 리뷰 문서 저장
# (선택에 따라 README.md / REVIEW.md / docs/REVIEW.md)

# 커밋 & 푸시
git add <파일>
git commit -m "docs: add comprehensive project review document"
git push
```

---

## 출력 형식

최종 문서는 위 8개 섹션을 포함한 단일 마크다운 파일입니다.

```markdown
# [프로젝트명] — 프로젝트 리뷰 문서

> 📅 리뷰 일자: 2026-04-16
> 📌 리뷰 범위: 전체 코드베이스
> 🎯 대상 독자: 이 프로젝트에 처음 투입되는 개발자

## 목차
...

## 1. 프로젝트 개요
...

## 2. 필수 사전 지식
...

## 3. 아키텍처 & 폴더 구조
...

## 4. DB 구조
...

## 5. 서버 구조 & 연결
...

## 6. 주요 함수 & 변수 레퍼런스
...

## 7. TODO & 기술 부채
...

## 8. 보안 & 버그 리포트
...
```

## 참고사항
- 파일 수가 많은 프로젝트는 Phase 1에서 시간이 걸릴 수 있습니다. 핵심 파일부터 우선 읽습니다.
- 기존 README.md가 있으면 반드시 백업 여부를 확인합니다.
- 민감 정보(실제 비밀번호, API 키 값)는 리뷰 문서에 절대 포함하지 않습니다. 위치만 기록합니다.
- 함수 레퍼런스(섹션 6)는 파일이 많을 경우 핵심 비즈니스 로직 파일을 우선 작성하고, 유틸은 요약합니다.
