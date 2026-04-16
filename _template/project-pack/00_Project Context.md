---
type: project_context
project: {{project}}
status: active # active / paused / completed / archived
created: {{date}}
updated: {{date}}
source_context: []
related_docs: []
tags: []
---

# Project Summary

프로젝트를 한 문단으로 설명합니다. 이 프로젝트에 처음 투입된 사람이 이 단락만 읽고 전체 맥락을 파악할 수 있어야 합니다.

<!-- 예: "사내 직원 150명이 사용하는 휴가 관리 시스템. 기존 엑셀 기반 프로세스를 웹 앱으로 전환하는 프로젝트로, 폐쇄망 환경에서 운영되며 사내 LDAP 인증을 사용한다. Node.js + React + PostgreSQL 기반이며, Docker로 배포한다." -->

## Goal

프로젝트의 최종 목표를 구체적으로 기술합니다. 측정 가능한 형태가 이상적입니다.

- <!-- 예: 엑셀 기반 휴가 신청을 웹 앱으로 대체하여 처리 시간을 3일 → 즉시로 단축 -->
- <!-- 예: 월간 활성 사용자(MAU) 1,000명 달성 -->

## Current Stage

프로젝트의 현재 단계를 명시합니다.

- Stage: <!-- planning / design / active-dev / testing / staging / production / maintenance -->
- Milestone: <!-- 현재 마일스톤 — 예: "v1.0 MVP 출시" -->
- Target date: <!-- 예: 2026-06-30 -->
- Progress: <!-- 예: "백엔드 API 80% 완료, 프론트엔드 40%, DB 마이그레이션 완료" -->

## Users Or Audience

이 프로젝트의 사용자 또는 고객이 누구인지 정의합니다.

- Primary user: <!-- 예: 사내 직원 (비기술직 포함) -->
- Secondary user: <!-- 예: HR 관리자, 팀 리드 -->
- User count: <!-- 예: 약 150명 -->
- Technical literacy: <!-- 예: 낮음 — 직관적 UI 필수 -->

## Constraints

프로젝트의 기술적·환경적·조직적 제약을 기록합니다. 이 항목이 불명확하면 나중에 반드시 문제가 됩니다.

- Environment: <!-- 예: 폐쇄망 — 외부 네트워크 접근 불가, 내부 미러 사용 -->
- Tech stack: <!-- 예: Node.js 20, React 18, PostgreSQL 15, Docker -->
- Authentication: <!-- 예: 사내 LDAP (Active Directory) 연동 필수 -->
- Budget: <!-- 예: 외부 SaaS 사용 불가, 서버 2대 제한 -->
- Timeline: <!-- 예: 3개월 내 MVP, 6개월 내 전사 배포 -->
- Team: <!-- 예: 개발자 2명 (풀타임 1, 파트타임 1) -->
- Regulatory: <!-- 예: 개인정보 보호법 준수 필요, 감사 로그 의무 -->

## Success Signals

프로젝트가 성공했다고 판단할 수 있는 구체적 신호를 정의합니다.

- <!-- 예: 전체 직원의 80%가 웹 앱으로 휴가를 신청한다 (엑셀 사용률 < 20%) -->
- <!-- 예: 휴가 승인 처리 시간이 평균 1시간 이내로 단축된다 -->
- <!-- 예: 월간 사용자 불만 접수가 3건 이하이다 -->

## References

관련 문서, 디자인 파일, 외부 시스템 링크를 모읍니다.

- Design: <!-- Figma URL, 와이어프레임 위치 -->
- API Spec: <!-- Swagger/OpenAPI 문서 위치 -->
- External systems: <!-- 연동 시스템 문서 — 예: LDAP 설정 가이드 -->
- Previous work: <!-- 이전 프로젝트나 PoC 링크 -->
- Meeting notes: <!-- 킥오프 회의록, 의사결정 기록 -->
