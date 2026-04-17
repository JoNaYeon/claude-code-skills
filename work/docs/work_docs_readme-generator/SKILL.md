---
name: work_docs_readme-generator
description: "Use this skill when the user wants to create or update a README.md file for their project. Triggers on: 'create README', 'generate README', 'write README', 'update README', 'README 만들어줘', 'README 작성해줘', '프로젝트 문서화', '리드미 써줘'."
---

# README Generator

## 목적
프로젝트 구조와 코드를 분석하여 완성도 높은 README.md를 자동 생성합니다.

## 지침

### 1. 프로젝트 분석
다음 파일들을 읽어 프로젝트를 파악합니다:
```bash
# 프로젝트 구조
find . -maxdepth 2 -not -path '*/node_modules/*' -not -path '*/.git/*'

# 의존성 및 스크립트
cat package.json        # Node.js
cat requirements.txt    # Python
cat go.mod             # Go
cat pom.xml            # Java
```

파악할 정보:
- 프로젝트 이름과 목적
- 사용 기술 스택
- 실행/빌드 명령
- 환경변수 (`.env.example` 등)
- 폴더 구조와 역할
- 기존 테스트 명령

### 2. 섹션 구성
프로젝트 성격에 따라 필요한 섹션을 선택합니다:
- 라이브러리/패키지: 설치, 사용법, API 레퍼런스 중심
- 웹 서비스: 스크린샷, 기능 목록, 배포 방법 중심
- CLI 도구: 명령어 목록, 옵션 설명 중심

### 3. README 작성
실제 코드에서 읽은 정보를 바탕으로 작성합니다.
추측이 필요한 경우 `<!-- TODO: 여기에 설명 추가 -->` 플레이스홀더를 사용합니다.

## 출력 형식

```markdown
# 프로젝트명

> 한 줄 설명

![badge](https://img.shields.io/...)

## 기능
- 주요 기능 1
- 주요 기능 2

## 시작하기

### 요구사항
- Node.js 18+
- ...

### 설치
\`\`\`bash
git clone https://github.com/user/repo
cd repo
npm install
\`\`\`

### 환경변수 설정
\`\`\`bash
cp .env.example .env
# .env 파일 편집
\`\`\`

### 실행
\`\`\`bash
npm run dev
\`\`\`

## 프로젝트 구조
\`\`\`
src/
├── ...
\`\`\`

## API (해당 시)
...

## 기여하기
...

## 라이선스
MIT
```
