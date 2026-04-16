---
description: "PDF 리포트 분석 요청 시 발동. inbox-pdf/ 폴더의 PDF를 읽고 4단계 검증 후 knowledge/ 폴더에 저장."
---

# PDF 리포트 인테이크

PDF 원본을 직접 분석하여 검증된 지식으로 변환한다.
블로그 요약 10개 읽는 것보다 원본 1개가 낫다.

## 프로세스

### 1. PDF 읽기

두 가지 추출 방법을 상황에 따라 선택:

#### 방법 A: markitdown (권장 — 구조 보존)
```bash
markitdown inbox-pdf/report.pdf -o /tmp/report_raw.md
```
- 표, 목차, 계층 구조를 마크다운으로 자동 변환
- 토큰 효율적이라 LLM 분석에 최적
- DOCX, XLSX, PPTX, EPUB도 동일하게 처리 가능

#### 방법 B: anthropic-skills:pdf (대형/복잡 PDF)
- anthropic-skills:pdf 스킬 활용하여 페이지 범위 지정 읽기
- 10페이지 이상 대형 PDF에 적합
- 이미지 내 텍스트(OCR) 필요 시 활용

두 방법 모두에서 핵심 데이터 포인트, 표, 그래프 설명을 추출

### 2. 4단계 비판적 검증

#### ① 출처 검증
- 발행 기관 확인 (한국은행, IMF, BIS, Fed, a16z 등 → primary)
- 기관 리포트가 아닌 개인 분석 PDF → secondary

#### ② 근거 검증
- 데이터/통계 기반 주장 → `[사실]`
- 분석가의 해석/전망 → `[해석]`
- 근거 불명확한 주장 → `[불명]`

#### ③ 반대 시나리오
- 리포트의 핵심 전망이 틀릴 수 있는 조건

#### ④ 적용성
- 사용자 상황(투자, 업무, 학습)에의 시사점

### 3. 인사이트 추출
- 핵심 데이터 포인트 (숫자, 날짜 포함)
- 주요 결론/전망 (최대 5개)
- 사용된 프레임워크나 분석 방법론

### 4. 저장

```yaml
---
type: knowledge
source_type: pdf
source_url: "리포트 출처 URL (있으면)"
source_quality: primary
confidence: high
verification_status: verified
counter_scenario: "반대 시나리오"
applicability: "적용성 판단"
verified_date: YYYY-MM-DD
tags: []
related_topics: []
---
```

파일명: `{기관}_{리포트주제}_{YYYYMMDD}.md`
저장 위치: `knowledge/{도메인}/`

## 참고 소스 목록 (memory/patterns.md 참조)
- 거시경제: 한국은행, IMF, BIS, Fed
- 크립토/테크: a16z, Messari
- 산업: 각 산업 공식 보고서
