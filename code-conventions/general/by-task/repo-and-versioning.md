# 저장소 구조·버전 축 (General)

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **General** — 재사용 가능. **사본** — SSOT는 전사 컨벤션 레포(비공개)의 `code-conventions/by-task/`. 상충 시 SSOT 우선.
> 조직 특이 정책(강화 규칙)은 비공개 조직 정책 레포에서 관리한다.

## 멀티레포 토폴로지

코드베이스를 유형별 **독립 레포**로 분리한다.

| 레포 유형 | 역할 | 명명 예 |
|-----------|------|---------|
| 제품 레포 | 제품 SW | `ecg-inference`, `hel-emr` |
| 공용 서비스 레포 | 런타임 공용(게이트웨이·알림) | `api-gateway`, `notification-svc` |
| 공유 라이브러리 레포 | 공용 lib → 패키지 배포 | `common-fhir`, `common-auth` |
| 계약 레포 | proto·OpenAPI 명세 SSOT | `contracts` |
| 인프라 레포 | IaC(Terraform/K8s) | `infra` |
| CI 레포 | 공용 CI 파이프라인 정의 | `ci` |

- 레포명 = `<제품|역할>-<컴포넌트>` kebab-case. 영문 소문자·숫자·`-`만.

## 단방향 의존 규칙

- cross-repo 의존은 소스 직접 참조가 아니라 **버전 패키지 의존**으로만.
- 순환 의존(cycle) 금지.
- 공유가 필요하면 공유 라이브러리 레포로 승격 후 패키지로 소비.

## 공유 코드·계약 배포

- 공유 라이브러리(`common-*`)는 패키지 레지스트리(Nexus 등)에 **SemVer 버전 패키지**로 배포. 소비 레포는 lockfile+`--require-hashes`로 고정 버전 참조(직접 소스 참조 금지).
- proto 계약은 계약 레포 SSOT → **Buf Schema Registry(BSR)**, `buf breaking`으로 파괴 차단.
- OpenAPI는 계약 레포 SSOT + Spectral(lint)·oasdiff(breaking) 게이트.

## cross-repo 일관성 (3층)

1. **레포 템플릿(scaffolding)** — 신규 레포는 표준 템플릿에서 생성(`.editorconfig`/CODEOWNERS/pre-commit 포함).
2. **전용 CI 레포(`ci`)** — 파이프라인 중앙 정의. 각 레포는 로컬 CI 파일 없이 `ci_config_path`로 참조.
3. **Terraform 프로비저닝(GitLab/GitHub-as-code)** — 레포 생성·CI 배선·보호 브랜치·CODEOWNERS를 IaC로 일괄 관리.

## 버전 축 (6축)

| 축 | 형식 | 규칙 |
|-----|------|------|
| 코드 | `vMAJOR.MINOR.PATCH` | 레포별 Git 태그 = 마스터 |
| 아티팩트 | 코드와 동일 SemVer | 코드에서 파생, 불일치 = CI fail |
| 이미지 | `vX.Y.Z-{git-sha}` | `+`불가→`-`치환, **`latest` 프로덕션 금지** |
| API/계약 | MAJOR만 노출 `/v1`·`pkg.v1` | 코드와 독립, Buf breaking |
| 데이터셋 | `v{M.m}_{YYYY-MM-DD}` | 동결 불변 |
| 문서 | `_v{M.m}` | 재승인 필요 변경 = MAJOR |

- **코드=아티팩트=이미지 = 레포별 단일 SemVer 정렬.** 세 축은 항상 동일 SemVer.
- **API/계약 = 독립 계약축.** 코드 PATCH/MINOR가 올라도 MAJOR만 유지.
- 이미지 `+{git-sha}`는 SemVer 빌드메타데이터. Docker 태그엔 `+` 불가 → `-{git-sha}`. 배포 고정은 다이제스트(`@sha256:`) 단위.
- 프리릴리스(`-rc.N`)·스냅샷(`-SNAPSHOT`/`.devN`)은 프로덕션 배포 금지.
