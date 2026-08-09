---
name: work_coding_security-audit
description: "Use this skill when the user wants to check code for security vulnerabilities, audit for security issues, or review code for potential exploits. Triggers on: 'security audit', 'check for vulnerabilities', 'security review', 'is this secure', '보안 검토', '취약점 확인', '보안 감사', '보안 문제 있어?'."
---

# Security Audit

## 목적
코드에서 보안 취약점을 탐지하고 안전한 대안을 제시합니다.

## 컨벤션 참조 (General / 조직 특이)
일반 OWASP 점검에 더해 레포 루트 `code-conventions/`의 보안 관련 규칙을 확인합니다.
- **General(항상)** — 시크릿 하드코딩 금지(gitleaks/detect-secrets), 에러 응답에 스택·SQL·내부 경로 노출 금지, 인증 Bearer/OPA. `code-conventions/general/by-task/error-handling-logging.md`·`toolchain-quality-gates.md`.
- **조직 특이(해당 조직 레포에서만, 최우선)** — 조직 소속 레포에서는 비공개 조직 정책 레포의 강화 규칙(민감 데이터 노출 금지 등)을 최우선으로 추가 적용하며, 위반은 보안 사고로 취급한다.

## 지침

### 1. 대상 파일 수집
```bash
git diff --name-only HEAD    # 변경된 파일 (빠른 검토)
# 또는 전체 프로젝트 주요 파일 검토
```

### 2. OWASP Top 10 기준 점검

#### A01 — Injection
- SQL 쿼리에 사용자 입력 직접 삽입 여부
- Command injection 가능성
- LDAP, XPath injection
- **탐지 패턴**: `query + userInput`, `exec(`, `eval(`

#### A02 — 인증 취약점
- 하드코딩된 비밀번호/API 키
- 취약한 해시 알고리즘 (MD5, SHA1)
- JWT secret이 코드에 포함
- **탐지 패턴**: `password = "`, `secret = "`, `md5(`, `sha1(`

#### A03 — XSS
- 사용자 입력을 HTML에 직접 삽입
- `innerHTML`, `document.write` 사용
- **탐지 패턴**: `innerHTML =`, `dangerouslySetInnerHTML`

#### A05 — 잘못된 설정
- 디버그 모드 프로덕션 노출
- CORS 와일드카드 (`*`)
- 불필요하게 넓은 권한

#### A06 — 취약한 의존성
- `dependency-audit` 스킬 연계 실행 권장

#### A09 — 로깅 취약점
- 민감 데이터(비밀번호, 토큰)가 로그에 기록
- **탐지 패턴**: `console.log(password`, `log(token`

### 3. 심각도 분류
- **Critical**: 즉시 수정 필요 (인젝션, 하드코딩 시크릿)
- **High**: 빠른 수정 권장 (XSS, 인증 취약점)
- **Medium**: 계획적 수정 (잘못된 설정)
- **Low**: 모범 사례 권장 사항

## 출력 형식

```markdown
## 보안 감사 결과

### 🔴 Critical
- **[SQL Injection]** `src/db.js:23` — 사용자 입력이 쿼리에 직접 삽입됨
  - 수정: Prepared statement 사용

### 🟠 High
- **[Hardcoded Secret]** `config.js:5` — API 키가 코드에 하드코딩
  - 수정: 환경변수로 이동

### 🟡 Medium
- **[CORS]** `app.js:12` — 모든 출처 허용 (`*`)
  - 수정: 허용 도메인 명시

### ✅ 이상 없음
- 인증 로직
- 세션 관리
```
