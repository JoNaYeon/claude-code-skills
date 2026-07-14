# 02 · 분류 원칙 — 조직 특징 분류와 규칙

> ⚠️ **최고 규칙(_init) — 일반 task 중 변경 금지.** 개정은 명시적 승인으로만.

## C1. 최상위 분류축 — General vs 조직 정책

모든 규칙은 **두 범주 중 하나**로 분류한다.

| 범주 | 정의 | 규칙 폴더 |
|------|------|-----------|
| **General** | 조직 무관, 다른 회사/프로젝트에도 그대로 재사용 가능한 것 | `*/general/` |
| **조직 정책 (조직 특이)** | 특정 **조직**의 도메인·규제·인프라 때문에만 존재하는 것 | `*/<조직>/` |

- General은 항상 적용한다. 조직 정책은 그 조직 레포에서만 추가 적용한다(→ [01_precedence.md](./01_precedence.md) P4).
- 기준선 질문: **"다른 조직/프로젝트에도 그대로 쓸 수 있나?"** → 예=General, 아니오=조직 정책.

## C2. 조직 레지스트리

전체 문서가 참조하는 **조직 목록과 각 조직의 특징·규칙**이다. 조직 추가·특징 변경은 `_init` 개정(승인)으로만 한다.

### SEEMEDI (의료 AI)

- **규칙 폴더**: `code-conventions/seemedi/`, `_template/_conventions/seemedi/`, `working-agreements/seemedi/`
- **레포 판별**: 레포 루트 `governance.yaml` 존재, 패키지 `com.seemedi.*`, 제품 접두 `ecg-`/`edo-`/`hel-`/`tlk-`
- **특징(축) → 규칙**:

| # | 특징 | 왜 특이한가 | 규칙 문서 |
|---|------|-------------|-----------|
| ① | 환자 데이터(PHI) | 보호대상 건강정보, 병원망 비반출 | `code-conventions/seemedi/by-task/patient-data-phi.md` |
| ② | DB/망 분리 | 식별 온프레미스 / 운영 AWS, 하이브리드·HSM | `code-conventions/seemedi/by-task/db-separation.md` |
| ③ | 규제(의료기기) | IEC 62304, governance.yaml, 규제 레포 격리 | `code-conventions/seemedi/by-task/regulated-track.md` |
| ④ | FHIR 의료용어 | FHIR R4/KR Core, finding/order/report | `code-conventions/seemedi/by-task/medical-terminology-fhir.md` |
| — | `seemedi` 네임스페이스·제품 | 회사 고유 식별자 | `code-conventions/seemedi/by-task/seemedi-namespace.md` |

> 새 조직이 생기면 이 레지스트리에 `### <조직>` 절을 추가하고 `*/<조직>/` 규칙 폴더를 만든다.

## C3. 특징 → 규칙 매핑 원칙

- 각 조직의 **특징(축)마다 규칙 문서 1개**를 둔다(특징이 규칙의 분류 단위).
- 규칙 문서 상단에 어느 조직·어느 특징에 속하는지, 근거 원본(SSOT)을 명시한다.

## C4. 폴더 분리 규칙

- 각 규칙 영역은 `general/`과 조직별 `<조직>/` 하위 폴더로 물리 분리한다.
- 재사용 시 `general/`만 복사하면 조직 의존 없이 다른 프로젝트에 이식 가능해야 한다.

---
> **개정 이력** · 2026-07-14: "General vs SEEMEDI 특이" 단일 분류에서 **조직 특징 분류·규칙 체계**(조직 레지스트리 + 특징→규칙 매핑)로 개정 (세션 승인).
