# 02 · 분류 원칙 — General vs SEEMEDI 특이

> ⚠️ **최고 규칙(_init) — 일반 task 중 변경 금지.** 개정은 명시적 승인으로만.

## C1. 최상위 분류축

모든 규칙은 **두 범주 중 하나**로 분류한다.

| 범주 | 정의 | 예 |
|------|------|-----|
| **General** | 다른 회사/프로젝트에도 그대로 재사용 가능한 것 | 코드 작성법, AWS 세팅, Git 워크플로우, API 설계, 문서 버전 규칙 |
| **SEEMEDI 특이** | 이 회사·의료·규제 때문에만 존재하는 것 | 환자 데이터(PHI), DB/망 분리, 규제(IEC 62304), FHIR 의료용어, `seemedi` 네임스페이스 |

## C2. 판별 기준

- 기준선 질문: **"다른 회사/프로젝트에도 그대로 쓸 수 있나?"** → 예=General, 아니오=SEEMEDI 특이.
- SEEMEDI 특이의 4대 축: **① 환자 데이터(PHI) ② DB/망 분리 ③ 규제(의료기기) ④ FHIR 의료용어**. 이 중 하나에 속하면 SEEMEDI 특이.

## C3. 폴더 분리 규칙

- 각 규칙 영역은 `general/`과 `seemedi/` 하위 폴더로 물리 분리한다.
- 재사용 시 `general/`만 복사하면 다른 프로젝트에 이식 가능해야 한다(SEEMEDI 의존 없음).

## C4. 적용 규칙

- **General 규칙은 항상 적용**한다.
- **SEEMEDI 특이 규칙은 SEEMEDI 레포에서 작업할 때만 추가 적용**한다.
- SEEMEDI 레포 판별: 레포 루트 `governance.yaml` 존재, 패키지 `com.seemedi.*`, 제품 접두 `ecg-`/`edo-`/`hel-`/`tlk-`.
- 충돌 시 우선순위는 [01_precedence.md](./01_precedence.md) P4.
