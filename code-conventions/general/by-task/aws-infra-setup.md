# AWS·인프라 세팅 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. 출처: SEEMEDI `STD-TERM-0001` §7, `STD-STACK-0001` §3.6~3.8에서 온프레미스·HSM·병원망 특이 제거.
> 하이브리드(온프레미스 K3s)·HSM 키·GitLab 프라이빗 VPC: [../../seemedi/by-task/db-separation.md](../../seemedi/by-task/db-separation.md)

## 인프라 리소스 명명

`{company}-{env}-{domain}-{product}-{resource}` **kebab-case** (MUST).

| 세그먼트 | 예 | 설명 |
|----------|-----|------|
| company | `acme` | 전사 고정 접두 |
| env | dev / stg / prod | 환경 |
| domain | 제품/기능 도메인 | |
| product | 제품 약칭/컴포넌트 | 선택(domain 중복 시 생략) |
| resource | eks / s3 / rds / sg / svc | 리소스 종류 |

예: `acme-prod-web-api-eks`, `acme-stg-shared-core-rds`

## AWS 필수 태그 (MUST)

모든 AWS 리소스에 부여: `company`, `env`, `domain`, `product`, `owner`, `cost-center`, `data-sensitivity`, `regulated`.

| 태그 키 | 예 |
|---------|-----|
| env | prod |
| domain | web |
| owner | team-web |
| data-sensitivity | L1~L4 |
| regulated | true/false |

## 인프라 스택 (일반)

| 계층 | 승인 기술 |
|------|-----------|
| 컨테이너 | Docker (이미지 태그·버전=버전축) |
| 오케스트레이션 | Kubernetes (AWS=EKS) |
| 서비스 메시 | Istio (mTLS·트래픽 정책) |
| DB | PostgreSQL(운영) · Redis(캐시·세션·큐) · S3+Object Lock(저장·감사) |
| 인증/인가 | Keycloak(SSO·MFA) · OPA(Rego, 정책) |
| IaC | Terraform (인프라 SSOT + 레포/CI 배선) |
| GitOps | ArgoCD (승인 다이제스트만 배포) |

## 원칙

- **인프라는 Terraform IaC로 관리**(SSOT). 수기 콘솔 변경 지양.
- S3 감사 로그는 **WORM(Object Lock) + 해시 체이닝**.
- Redis는 휘발성 — 영속 원본 저장 금지.
- 컨테이너 베이스 이미지는 digest 고정, 프로덕션 `latest` 금지.
- 신규 기술 도입은 ADR 작성 → 아키텍트 승인 → 스택 표준 등재 절차.
