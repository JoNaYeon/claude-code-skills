---
description: "사용자가 기사, 블로그 글, X 스레드 등을 붙여넣을 때 자동 발동. 4단계 비판적 검증 후 knowledge/ 폴더에 저장."
---

# 기사/글 인테이크

사용자가 기사나 글을 붙여넣으면 아래 프로세스를 실행한다.

## 1단계: 4단계 비판적 검증

### ① 출처 검증
- 이 글은 **1차 자료**(원저자, 공식 데이터)인가, **해석**(누군가의 분석/요약)인가?
- 저자/출처의 신뢰도는?
- `source_quality` 판정: primary / secondary / tertiary

### ② 근거 검증
- 주장에 **데이터**가 있는가, **의견**인가, **추측**인가?
- 각 주요 주장에 `[사실]` / `[해석]` / `[불명]` 태그 부여

### ③ 반대 시나리오
- 이 주장이 **틀릴 수 있는 조건**은 무엇인가?
- 반대 논거나 대안 시나리오 제시

### ④ 적용성
- 이 내용이 **나(사용자)의 상황**에 해당되는가?
- 실제 의사결정이나 행동에 어떻게 연결되는가?

## 2단계: 인사이트 추출

- 검증 통과한 핵심 인사이트만 추출 (최대 5개)
- 각 인사이트에 근거 수준 표기

## 3단계: 저장

아래 프론트매터 형식으로 `knowledge/{적절한 도메인}/` 폴더에 마크다운 파일 저장:

```yaml
---
type: knowledge
source_type: article
source_url: "원본 URL"
source_quality: primary | secondary | tertiary
confidence: high | medium | low
verification_status: verified
counter_scenario: "반대 시나리오 요약"
applicability: "적용성 판단 요약"
verified_date: YYYY-MM-DD
tags: []
related_topics: []
---
```

파일명: `{주제요약}_{YYYYMMDD}.md`

## 도메인 분류 기준
- tech/ — 기술, 엔지니어링, AI, 개발
- finance/ — 경제, 투자, 환율, 거시경제
- product/ — 프로덕트, UX, 비즈니스 전략
- general/ — 위에 해당하지 않는 경우

## 중요
- 검증 결과를 사용자에게 먼저 보여주고, 저장 여부 확인 후 저장
- `memory/patterns.md`의 검증 기본값 참조
