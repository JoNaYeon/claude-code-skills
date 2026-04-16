---
type: knowledge
created: <% tp.date.now("YYYY-MM-DD") %>
updated: <% tp.date.now("YYYY-MM-DD") %>
source_type: # article / book / paper / video / podcast / conversation / experience
source_title:
source_url:
source_quality: # primary(원본) / secondary(요약·해설) / tertiary(위키·교과서)
confidence: # high / medium / low — 검증 정도에 따라
verification_status: unverified # unverified / partially-verified / verified / challenged
counter_scenario: # 이 지식이 틀릴 수 있는 가장 큰 조건 한 줄
applicability: # personal / project-specific / universal
verified_date:
tags: []
related_topics: []
---

# <% tp.file.title %>

## Summary

한 문단으로 핵심만 요약합니다. "이것만 읽으면 이 노트의 80%를 이해할 수 있다"를 기준으로 작성합니다.

<!-- 예: "분산 시스템에서 CAP 정리는 Consistency, Availability, Partition tolerance 중 최대 2개만 동시에 만족할 수 있다는 이론적 한계를 말한다. 단, 실제로는 Partition이 항상 발생하므로 CP vs AP 중 선택하는 문제로 귀결된다." -->

## Key Insights

이 소스에서 가져온 핵심 인사이트를 3~5개로 정리합니다. 각 항목은 독립적으로 이해 가능하게 작성합니다.

- <!-- 인사이트 1 -->
- <!-- 인사이트 2 -->
- <!-- 인사이트 3 -->

## Evidence Notes

각 근거를 유형별로 태깅합니다. 나중에 검증할 때 어떤 부분이 팩트이고 어떤 부분이 해석인지 구분하기 위함입니다.

- [fact] <!-- 출처에서 확인 가능한 객관적 사실 -->
- [fact] <!-- 예: "2024년 기준 PostgreSQL은 MVCC를 사용한다 (공식 문서)" -->
- [interpretation] <!-- 내가 해석한 의미 — 원문에 명시되지 않은 추론 -->
- [interpretation] <!-- 예: "이 패턴은 마이크로서비스보다 모놀리스에서 더 유효할 것으로 보인다" -->
- [unclear] <!-- 아직 확인하지 못했거나 모호한 부분 -->
- [unclear] <!-- 예: "저자가 말한 '실시간'이 100ms인지 1s인지 불분명" -->

## Counter Scenario

이 내용이 틀리거나 유효하지 않을 수 있는 조건을 적극적으로 찾습니다. 확증 편향을 방지하는 가장 중요한 섹션입니다.

- 이 내용이 틀릴 수 있는 조건: <!-- 예: "트래픽이 매우 적은 서비스에서는 이 최적화가 오히려 오버헤드" -->
- 반대 의견이나 대안적 관점: <!-- 예: "Martin Fowler는 반대로 X를 주장" -->
- 시간이 지나면 무효화되는 조건: <!-- 예: "특정 프레임워크 버전에만 해당" -->

## Applicability

추상적 지식을 내 상황에 구체적으로 연결합니다. 연결되지 않는 지식은 잊힙니다.

- 내 상황과 연결되는 지점: <!-- 예: "현재 프로젝트의 인증 모듈에서 이 패턴을 적용 가능" -->
- 실제 행동이나 의사결정으로 이어질 수 있는 부분: <!-- 예: "다음 리팩토링 때 세션 관리를 JWT로 교체 검토" -->
- 주의사항: <!-- 예: "우리 프로젝트는 폐쇄망이라 외부 인증 서버 사용 불가" -->

## Follow-ups

- 추가로 검증할 것: <!-- 구체적인 확인 항목 — 예: "PostgreSQL MVCC의 vacuum 부하를 실측" -->
- 연결할 노트: <!-- [[관련 노트]] 형식으로 링크 -->
- 더 읽을 자료: <!-- URL 또는 제목 -->
