# CODE_QUALITY — 커밋 전 품질 게이트

> Governed by ai-ops-harness `_init` — 최고 규칙 계층. 충돌 시 _init 우선.

<!-- 프로젝트 루트에 CODE_QUALITY.md로 복사한 뒤 프로젝트에 맞게 조정하세요. -->

순서 고정: 품질 검수 → Git 작업. 아래 변경 유형별 체크리스트를 커밋 전에 확인합니다.

## 공통 (모든 변경)

- [ ] 비밀값(키·토큰·비밀번호·내부 URL)이 diff에 없다 — `scripts/pre-commit`이 2중 확인
- [ ] 생성·수정한 파일이 구조 선언에 있던 것과 일치한다
- [ ] 주석은 코드가 보여줄 수 없는 제약만 서술한다

## 재현성 (의존성·버전 고정)

<!-- 출처: code-conventions/by-task/toolchain-quality-gates.md (이 레포가 SSOT — 2026-08-07 이관) 요약.
     상충 시 정본(전사 코드 컨벤션)이 우선한다. -->

- [ ] 의존성은 락 파일로 고정하고 락 파일을 커밋한다 — CI는 락 정확 일치 설치
      (`npm ci`, `uv sync --frozen` 등). 범위 지정(`^`·`~`·`>=`)으로 새 의존성을 넣지 않는다
- [ ] 컨테이너 베이스 이미지는 태그가 아니라 digest(`@sha256:`)로 고정 — `latest`·이동 태그 금지
- [ ] 린터·포매터 규칙을 로컬에서 완화하지 않는다 — 강화만 허용

## 애플리케이션 코드

- [ ] 테스트가 있으면 실행해 통과 확인 — 실패 상태로 커밋하지 않는다
- [ ] 린터·포매터 실행 (프로젝트 표준: `<lint 명령>`)
- [ ] 에러 처리: 외부 호출(API·DB·파일)에 실패 경로가 있다

## 도메인 체크리스트 (프로파일별 이어붙임)

llm 프로파일은 `harness/roles/llm/CODE_QUALITY.llm.md`, devops 프로파일은
`harness/roles/devops/CODE_QUALITY.devops.md`를 이 파일 끝에 이어붙인다 — general에는
도메인 규칙을 두지 않는다(harness/README.md 상속 규칙 1).

## 문서

- [ ] 템플릿 기반 문서는 해당 템플릿(`templates/`)의 필수 섹션을 모두 채웠다
- [ ] 조직별 값은 config 키 참조로 — 실값을 문서에 쓰지 않는다
