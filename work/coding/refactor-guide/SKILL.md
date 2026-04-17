---
name: refactor-guide
description: "Use this skill when the user asks to refactor code, improve code structure, reduce duplication, or clean up messy code. Triggers on: 'refactor this', 'clean up this code', 'improve code structure', 'reduce duplication', 'simplify this', '리팩토링해줘', '코드 정리해줘', '구조 개선', '중복 제거해줘', '코드 깔끔하게'."
---

# Refactor Guide

## 목적
기존 코드의 구조를 개선하여 가독성, 유지보수성, 확장성을 높입니다.

## 지침

### 1. 현황 분석
- 대상 코드를 읽고 현재 구조를 파악합니다.
- 코드 스멜(code smell)을 식별합니다:
  - 긴 함수 (Long Method)
  - 큰 클래스 (Large Class)
  - 코드 중복 (Duplicated Code)
  - 과도한 매개변수 (Long Parameter List)
  - Feature Envy / Shotgun Surgery

### 2. 리팩토링 계획 수립
- 변경 범위와 영향을 분석합니다.
- 기존 테스트가 있는지 확인합니다.
- 단계별 리팩토링 순서를 정합니다.

### 3. 리팩토링 실행
- 한 번에 하나의 리팩토링만 적용합니다.
- 각 단계 후 동작이 변하지 않았는지 확인합니다.
- 일반적인 리팩토링 기법:
  - **Extract Function**: 긴 함수에서 의미 있는 블록 분리
  - **Rename**: 의도를 명확히 드러내는 이름으로 변경
  - **Move**: 더 적절한 모듈/클래스로 이동
  - **Inline**: 불필요한 간접 참조 제거
  - **Replace Conditional with Polymorphism**: 복잡한 조건문 대체

## 출력 형식

```markdown
## 리팩토링 분석

### 발견된 코드 스멜
- [항목]: 설명

### 제안 리팩토링
1. [기법명] — 대상과 이유
2. ...

### Before / After
(코드 비교)
```
