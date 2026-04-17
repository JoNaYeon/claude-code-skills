---
description: "Use this skill when the user wants to check for vulnerable, outdated, or unnecessary dependencies. Triggers on: 'check dependencies', 'audit packages', 'outdated packages', 'vulnerable packages', '의존성 확인', '패키지 점검', '취약한 패키지', '오래된 패키지 확인해줘'."
---

# Dependency Audit

## 목적
프로젝트의 의존성 파일을 분석하여 취약하거나 오래된 패키지를 탐지하고 업데이트를 제안합니다.

## 지침

### 1. 프로젝트 유형 파악
의존성 파일을 확인합니다:
- **Node.js**: `package.json`, `package-lock.json`
- **Python**: `requirements.txt`, `Pipfile`, `pyproject.toml`
- **Go**: `go.mod`
- **Java/Kotlin**: `pom.xml`, `build.gradle`

### 2. 내장 감사 도구 실행
```bash
# Node.js
npm audit
npm outdated

# Python
pip list --outdated
safety check   # safety 설치된 경우

# Go
go list -m -u all
```

### 3. 결과 분석
- **취약 패키지**: CVE 번호와 심각도 확인
- **오래된 패키지**: 현재 버전 vs 최신 버전 비교
- **사용하지 않는 패키지**: 코드에서 import하지 않는 패키지

### 4. 업데이트 계획 수립
- Breaking change가 있는 메이저 업데이트는 별도 주의
- 사용자에게 확인 후 업데이트 실행

```bash
# Node.js — 안전한 패치/마이너 업데이트
npm audit fix

# 특정 패키지 업데이트
npm install <패키지>@latest
```

### 5. 업데이트 후 검증
```bash
npm test   # 또는 프로젝트에 맞는 테스트 명령
```

## 출력 형식

```markdown
## 의존성 감사 결과

### 🔴 취약 패키지 (즉시 업데이트 필요)
| 패키지 | 현재 버전 | 안전 버전 | CVE | 심각도 |
|--------|-----------|-----------|-----|--------|
| lodash | 4.17.15 | 4.17.21 | CVE-2021-23337 | High |

### 🟡 오래된 패키지 (업데이트 권장)
| 패키지 | 현재 | 최신 | 변경 유형 |
|--------|------|------|-----------|
| axios | 0.27.0 | 1.6.0 | Major |
| dayjs | 1.11.0 | 1.11.10 | Patch |

### ✅ 업데이트 명령
\`\`\`bash
npm audit fix           # 자동 수정 가능 항목
npm install lodash@latest  # 수동 업데이트 필요 항목
\`\`\`
```
