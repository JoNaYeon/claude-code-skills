# claude-code-skills — Claude Code 운영 규칙

<!-- 프로젝트 루트에 CLAUDE.md로 복사한 뒤 <PLACEHOLDER>를 치환하세요.
     이 파일은 선언과 프로젝트 고유 사항만 담는다 — 역할·조직 조각의 import는 넣지 않는다.
     `scripts/set-context.sh`가 아래 선언 주석을 관리하고 `CLAUDE.local.md`(gitignore)에
     조각 import를 채운다. 손으로 `@` 줄을 추가하지 않는다. 확인: /memory -->

<!-- harness: org=none role=none -->

## Overview

<이 저장소가 무엇을 운영하는 곳인지 한 단락. 제품 설명이 아니라 운영 체계 설명 —
예: "LLM 파인튜닝 실험과 서비스 배포 파이프라인을 Claude Code 하네스로 운영한다.">

## 프로젝트 특이 규칙 (선택)

<역할·조직 규칙의 강화·구체화만 적는다 — 완화 금지. 예: "이 프로젝트의 prod 컨텍스트
이름은 `{environments.cluster_prod}`", "실험 로그는 `{training.experiments_dir}` 아래".
조직 값은 `config/ops.config.yml` 또는 `harness/orgs/<org>/org.config.yml`에 두고
여기서는 키만 참조한다.>
