---
name: work_ai_skill-evaluation
description: "Use this skill to evaluate and review a candidate skill before installing it. Triggers on: 'evaluate skill', 'review skill', 'should I install this skill', 'skill trust check', '스킬 평가', '스킬 검토'."
---


# Skill Evaluation: {{title}}

## 1. Candidate Overview

평가 대상 스킬의 기본 정보입니다.

- Skill name: <!-- 예: code-review -->
- Source repo: <!-- 예: github.com/user/skill-repo -->
- Source URL: <!-- 직접 다운로드/설치 URL -->
- skills.sh page: <!-- skills.sh 페이지가 있으면 기록 -->
- Maintainer / publisher: <!-- 개인 / 조직명 / Anthropic 공식 -->
- Install command: <!-- 예: claude skill install code-review -->
- Category: <!-- coding / git / documentation / productivity / devops / testing -->

## 2. Why I Am Looking At This Skill

도입을 검토하는 맥락을 명확히 기록합니다. "그냥 좋아 보여서"는 근거가 되지 않습니다.

- Current project or workflow: <!-- 어떤 프로젝트에서 필요한지 -->
- Problem to solve: <!-- 구체적인 문제점 — 예: 매번 수동 코드 리뷰에 30분씩 소요 -->
- What I want the skill to do: <!-- 기대하는 동작 -->
- Why existing workflow is not enough: <!-- 현재 방식의 한계 -->

## 3. Quick Trust Check

스킬을 설치하기 전 최소한의 신뢰성 검증입니다.

- Official / trusted source 여부: <!-- Anthropic 공식 / 검증된 커뮤니티 / 개인 / 불분명 -->
- Install count / popularity: <!-- GitHub stars, 다운로드 수, 커뮤니티 언급 빈도 -->
- Repo activity / freshness: <!-- 최근 커밋 날짜, 이슈 응답 속도, 마지막 릴리즈 -->
- README / SKILL.md clarity: <!-- 문서화 품질 — 설치·사용법·제한사항이 명확한지 -->
- External tool or credential requirements: <!-- 추가로 필요한 도구나 API 키 -->
- Data / permission risk: <!-- 파일 시스템 접근 범위, 네트워크 호출 여부, 민감 데이터 처리 -->

**Red flags (하나라도 해당되면 skip 또는 pilot 강력 권장)**:
- [ ] 코드가 난독화되어 있거나 읽을 수 없음
- [ ] 필요 이상의 파일 시스템/네트워크 접근
- [ ] 외부 서버로 데이터를 전송
- [ ] 유지보수가 1년 이상 중단됨
- [ ] 문서가 거의 없음

## 4. Fit Check

각 항목을 1~5점으로 평가합니다. (1=매우 부족, 3=보통, 5=매우 우수)

| Criterion | Score | Notes |
|---|---|---|
| Relevance to real task | /5 | <!-- 실제 반복 작업을 직접 해결하는가 --> |
| Quality of instructions | /5 | <!-- SKILL.md의 지침이 명확하고 구체적인가 --> |
| Source trust | /5 | <!-- 출처가 신뢰할 만한가 --> |
| Setup cost | /5 | <!-- 설치·설정이 간단한가 (5=바로 사용, 1=복잡한 설정 필요) --> |
| Long-term reuse | /5 | <!-- 이 프로젝트 외에도 재사용 가능한가 --> |
| Risk / blast radius | /5 | <!-- 문제 발생 시 영향 범위가 작은가 (5=안전, 1=위험) --> |

**총점**: /30 — 20 이상이면 adopt 검토, 15~19면 pilot, 15 미만이면 skip 권장.

## 5. Review Checklist

설치 전 최종 확인 항목입니다.

- [ ] 이 스킬이 실제 반복 작업을 해결하는지 확인했다.
- [ ] 같은 일을 하는 공식/더 단순한 스킬이 없는지 확인했다.
- [ ] 레포/배포자의 신뢰도를 확인했다.
- [ ] 필요한 외부 도구, API, 시크릿을 확인했다.
- [ ] 스킬의 범위가 필요 이상으로 넓지 않은지 확인했다.
- [ ] 로컬 커스텀 스킬로 더 깔끔하게 대체 가능한지 검토했다.

## 6. Recommendation

- Decision: <!-- adopt now / pilot first / watchlist / skip -->
- Best use case: <!-- 이 스킬이 가장 빛나는 구체적 시나리오 -->
- Why this is a fit: <!-- 2번(검토 이유)과 연결하여 설명 -->
- Main risk: <!-- 가장 큰 위험 요인 한 가지 -->
- Review before rollout: <!-- 본격 도입 전 추가로 확인할 사항 -->

## 7. If Adopted

도입이 결정되면 이 섹션을 채웁니다.

- Add to which project: <!-- 레포/프로젝트명 -->
- Add as baseline or optional: <!-- baseline (모든 세션에 로드) / optional (필요시 호출) -->
- What prompt should call it: <!-- 예: "코드 리뷰해줘" 또는 /review -->
- What should be documented for future me: <!-- 사용법, 주의사항, 커스텀 설정 -->

## 8. Notes

- Links: <!-- 참고 링크 -->
- Examples: <!-- 실제 사용 예시 또는 결과 스크린샷 -->
- Open questions: <!-- 아직 확인하지 못한 사항 -->
