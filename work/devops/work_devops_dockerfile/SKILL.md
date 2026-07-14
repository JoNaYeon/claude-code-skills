---
name: work_devops_dockerfile
description: "Use this skill when the user asks to create, review, or optimize a Dockerfile. Triggers on: 'create a Dockerfile', 'write Dockerfile', 'review my Dockerfile', 'optimize Docker image', 'containerize this app', 'Docker best practices', 'Dockerfile 만들어줘', '도커파일 작성해줘', '도커 이미지 최적화', '컨테이너화해줘'."
---

# Dockerfile Generator & Reviewer

## 목적
프로젝트에 맞는 Dockerfile을 생성하거나 기존 Dockerfile의 문제점을 찾아 개선합니다.

## 컨벤션 참조 (General / SEEMEDI 특이)
이미지·인프라 규칙은 레포 루트 `code-conventions/`를 따릅니다.
- **General(항상)** — `code-conventions/general/by-task/aws-infra-setup.md`·`repo-and-versioning.md`: 베이스 이미지 **digest 고정**(`@sha256:`, `latest` 금지), 이미지 태그 `vX.Y.Z-{git-sha}`, 리소스 명명 `{company}-{env}-{domain}-{resource}`, AWS 필수 태그.
- **SEEMEDI 특이(SEEMEDI 레포에서만)** — `code-conventions/seemedi/by-task/db-separation.md`: 하이브리드(AWS EKS/온프레미스 K3s), 외부 아티팩트는 **폐쇄망 Nexus 프록시 경유**, 이미지에 PHI·시크릿 미포함, HSM 키는 온프레미스. regulated 레포는 SBOM 첨부 필수.
- SEEMEDI 레포 판별: `governance.yaml`·제품 접두 `ecg-/edo-/hel-/tlk-`.

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
