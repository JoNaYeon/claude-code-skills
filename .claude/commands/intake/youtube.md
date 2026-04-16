---
description: "유튜브 영상 내용을 정리할 때 발동. NotebookLM 요약 결과를 붙여넣거나 유튜브 URL을 공유할 때 사용. [2차요약] 태그로 비원본 소스임을 명시."
---

# 유튜브 인테이크

유튜브 영상은 클로드가 직접 시청할 수 없으므로 아래 2가지 경로로 처리한다.

## 경로 A: NotebookLM 경유 (주력)

사용자가 NotebookLM 요약 결과를 붙여넣는 경우:

### 전처리
- **반드시 `[2차요약]` 태그 부여** — 이건 이미 AI가 한 번 해석한 것이다. 원본이 아니다.
- `source_quality: secondary` 자동 설정
- 주장의 정확성에 더 높은 주의를 기울인다

### NotebookLM 사용 안내 (사용자 참고용)
사용자가 NotebookLM에서 사용할 프롬프트:
```
이 영상의 내용을 아래 구조로 요약해줘. 원저자의 주장을 왜곡하지 말고 있는 그대로 정리해줘.

1. 영상 정보 (제목, 채널명, 핵심 주제)
2. 주요 주장 최대 5개 (근거 없으면 '의견' 표기)
3. 인상적인 문장 원문 그대로 인용
```

## 경로 B: markitdown 활용

유튜브 URL이 제공된 경우 markitdown으로 자막/메타데이터 추출 시도:
```bash
markitdown "https://www.youtube.com/watch?v=VIDEO_ID"
```
- markitdown이 유튜브 URL에서 자막 및 메타데이터를 마크다운으로 변환
- 자막 추출 성공 시 → 1차 자료로 취급 가능 (`source_quality: primary`)
- 자막 없을 경우 → NotebookLM 경로 안내

## 4단계 비판적 검증

### ① 출처 검증
- 영상 제작자의 전문성/신뢰도
- NotebookLM 경유 시: `source_quality: secondary` (AI 해석 1회 거침)
- markitdown 자막 추출 시: `source_quality: primary` (원본 자막)

### ② 근거 검증
- 주장에 데이터/출처가 있는지
- 의견과 사실 구분 (특히 2차 요약에서 더 엄격하게)

### ③ 반대 시나리오
- 발표자의 주장이 틀릴 수 있는 조건

### ④ 적용성
- 내 상황에의 시사점

## 저장

```yaml
---
type: knowledge
source_type: youtube
source_url: "유튜브 영상 URL"
source_quality: secondary  # NotebookLM 경유 시. markitdown 자막 추출 시 primary
confidence: medium
verification_status: verified
counter_scenario: "반대 시나리오"
applicability: "적용성 판단"
verified_date: YYYY-MM-DD
tags: ["[2차요약]"]  # NotebookLM 경유 시 반드시 포함
related_topics: []
---
```

파일명: `{채널명}_{주제요약}_{YYYYMMDD}.md`
저장 위치: `knowledge/{도메인}/`

## 중요
- [2차요약] 태그가 있는 노트는 향후 의사결정 시 "이건 AI가 해석한 것"임을 인식
- 원본 영상 URL은 반드시 `source_url`에 기록
