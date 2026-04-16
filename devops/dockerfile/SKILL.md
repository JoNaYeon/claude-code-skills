---
name: dockerfile
description: "Use this skill when the user asks to create, review, or optimize a Dockerfile. Triggers on: 'create a Dockerfile', 'write Dockerfile', 'review my Dockerfile', 'optimize Docker image', 'containerize this app', 'Docker best practices', 'Dockerfile 만들어줘', '도커파일 작성해줘', '도커 이미지 최적화', '컨테이너화해줘'."
---

# Dockerfile Generator & Reviewer

## 목적
프로젝트에 맞는 Dockerfile을 생성하거나 기존 Dockerfile의 문제점을 찾아 개선합니다.

## 지침

### 생성 시

1. 프로젝트의 언어/프레임워크를 파악합니다.
2. 패키지 매니저와 의존성 파일을 확인합니다.
3. 빌드 및 실행 명령을 파악합니다.
4. 다음 베스트 프랙티스를 적용합니다:

### 베스트 프랙티스
- **Multi-stage build**: 빌드 의존성과 런타임을 분리
- **Minimal base image**: alpine 또는 distroless 사용
- **Layer caching**: 변경 빈도가 낮은 레이어를 먼저 배치 (의존성 설치 → 소스 복사)
- **Non-root user**: 보안을 위해 루트가 아닌 사용자로 실행
- **.dockerignore**: 불필요한 파일 제외 (node_modules, .git, .env 등)
- **COPY vs ADD**: 단순 복사는 COPY 사용
- **Health check**: HEALTHCHECK 명령 포함
- **Specific tags**: `latest` 대신 구체적인 버전 태그 사용

### 리뷰 시

다음 항목을 점검합니다:
1. 이미지 크기 최적화 여부
2. 보안 취약점 (root 실행, 민감 파일 포함 등)
3. 캐시 효율성
4. 불필요한 레이어
5. .dockerignore 존재 여부

## 출력 형식

```dockerfile
# --- Build stage ---
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --production
COPY . .
RUN npm run build

# --- Production stage ---
FROM node:20-alpine
RUN addgroup -S app && adduser -S app -G app
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
USER app
EXPOSE 3000
HEALTHCHECK CMD wget -q --spider http://localhost:3000/health || exit 1
CMD ["node", "dist/index.js"]
```
