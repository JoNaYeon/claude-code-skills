---
type: scrap
created: <% tp.date.now("YYYY-MM-DD") %>
updated: <% tp.date.now("YYYY-MM-DD") %>
source_type: # article / tweet / conversation / screenshot / thought
source_title:
source_url:
source_quality: secondary # primary / secondary / tertiary
status: captured # captured / triaged / promoted / discarded
tags: []
related_topics: []
---

# <% tp.file.title %>

## Raw Capture

원문 발췌나 빠른 메모를 가공 없이 그대로 남깁니다.
완벽하게 정리하려고 하지 않습니다 — 속도가 핵심입니다.

<!-- 예:
> "The best code is no code at all. Every new line of code you willingly bring into the world
> is code that has to be debugged, code that has to be read and understood."
> — Jeff Atwood

또는 단순 메모:
"프로젝트 X에서 Redis pub/sub 대신 PostgreSQL LISTEN/NOTIFY를 쓰고 있다고 함. 규모가 작으면 충분하다는 의견."
-->

## Why It Might Matter

이 스크랩을 캡처한 이유를 한두 줄로 적습니다. 나중에 triage할 때 맥락을 되살리기 위함입니다.

- <!-- 예: "현재 프로젝트에서 메시지 큐 도입을 검토 중인데, 더 단순한 대안이 될 수 있음" -->

## Triage

이 스크랩의 다음 단계를 결정합니다 (작성 시점이 아닌, 나중에 revisit할 때 채웁니다):

- [ ] **keep** — 스크랩 상태로 보관 (아직 판단 보류)
- [ ] **verify → knowledge** — 검증 후 Knowledge Note로 승격 (`/intake/verify` 사용)
- [ ] **discard** — 가치 없음, 삭제

## Next Action

triage 결과에 따른 구체적 행동:

- <!-- 예: "검증: PostgreSQL LISTEN/NOTIFY의 메시지 유실 가능성 확인 → knowledge로 승격" -->
- <!-- 예: "discard: 이미 알고 있는 내용, 추가 가치 없음" -->
