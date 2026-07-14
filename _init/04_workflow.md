# 04 · 작업 방식 — 제안 후 실행 (공통 + 라우터)

> ⚠️ **최고 규칙(_init) — 일반 task 중 변경 금지.** 개정은 명시적 승인으로만.

## W1. 제안 후 실행 (승인 게이트, 전 task 공통)

파일을 만들거나 바꾸는 작업은 **먼저 제안하고, 사용자 승인이 난 뒤에 실행**한다. 먼저 실행하고 사후 보고하지 않는다.

- 새 문서 작성, 파일 이동/삭제, 구조 변경, 대량 편집 **전에** 계획을 제안하고 승인을 받는다.
- 조사·분석·읽기·메모리 저장은 승인 없이 해도 된다.
- **산출물(파일)을 만들거나 바꾸는 단계**에 승인 게이트를 둔다.
- 세부는 [working-agreements/general/propose-before-executing.md](../working-agreements/general/propose-before-executing.md).

## W2. `_init` 변경의 특별 게이트

- `_init` 폴더 변경은 일반 승인보다 강한 게이트를 적용한다 — 사용자의 **명시적 `_init` 개정 요청**이 있어야 한다([00_governance.md](./00_governance.md) G2·G3).

## W3. 충실한 보고

- 실행 결과를 사실대로 보고한다. 건너뛴 단계·실패·미완은 그대로 밝힌다.
- 되돌리기 어렵거나 외부로 나가는 작업(푸시·삭제·전송)은 사전 확인한다.

## W4. Task 유형별 워크플로우 (라우터)

작업을 아래 세 유형으로 나누고 각 파일의 규칙을 따른다.

| 유형 | 대상 | 문서 |
|------|------|------|
| 코드 작성 | 코드 생성·수정·리팩토링·삭제 | [04_workflow/code-authoring.md](./04_workflow/code-authoring.md) |
| 문서 작성 | 문서·규칙·메모 생성·개정 | [04_workflow/document-authoring.md](./04_workflow/document-authoring.md) |
| 일반 task | 조사·분석·운영·기타 | [04_workflow/general-task.md](./04_workflow/general-task.md) |

- 세 유형 모두 W1~W3(공통 게이트)을 상위로 따른다. 각 파일은 유형별 추가 규칙만 정의한다.

---
> **개정 이력** · 2026-07-14: 단일 04_workflow.md를 공통 게이트(W1~W3) + 라우터(W4)로 두고, 세부를 코드 작성·문서 작성·일반 task 3개 파일로 분리 (세션 승인).
