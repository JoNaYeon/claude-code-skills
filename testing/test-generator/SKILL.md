---
name: test-generator
description: "Use this skill when the user asks to generate tests, write unit tests, create test cases, or add test coverage. Triggers on: 'write tests for', 'generate tests', 'add test coverage', 'create test cases', 'unit test this'."
---

# Test Generator

## 목적
주어진 함수나 모듈에 대한 단위 테스트를 프로젝트의 기존 패턴에 맞춰 생성합니다.

## 지침

### 1. 기존 테스트 패턴 파악
- 프로젝트에 이미 있는 테스트 파일을 찾습니다.
- 사용 중인 테스트 프레임워크를 확인합니다 (Jest, Pytest, Go testing 등).
- 네이밍 컨벤션과 디렉토리 구조를 파악합니다.
- 기존 테스트의 스타일(AAA, Given-When-Then 등)을 따릅니다.

### 2. 테스트 케이스 설계
각 함수/메서드에 대해:
- **정상 케이스 (Happy path)**: 기대 입력으로 정상 동작 확인
- **엣지 케이스**: 빈 값, null, 경계값, 최대/최소값
- **에러 케이스**: 잘못된 입력, 예외 상황
- **타입별 입력**: 다양한 입력 타입에 대한 동작

### 3. 테스트 작성
- 하나의 테스트는 하나의 동작만 검증합니다.
- 테스트 이름은 "무엇을 테스트하는지" 명확히 표현합니다.
- 테스트 간 의존성을 없앱니다.
- mock은 필요한 경우에만 사용합니다.

### 4. 실행 및 확인
- 작성한 테스트를 실행합니다.
- 모든 테스트가 통과하는지 확인합니다.

## 출력 형식
프로젝트의 기존 테스트 패턴에 맞춘 테스트 파일을 생성합니다.
테스트 실행 결과를 함께 보고합니다.
