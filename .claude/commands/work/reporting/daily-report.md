---
description: "GitHub Issues를 읽고 요약하여 Slack 채널에 데일리 리포트를 업로드합니다. Triggers on: 'daily report', '데일리 리포트', 'issue 정리', 'slack에 올려줘', '작업 내용 공유', '오늘 작업 정리', 'issue slack 업로드', '깃허브 이슈 슬랙', '작업 사항 공유'."
---

# 📋 Daily Report — GitHub Issues → Slack

GitHub Issues를 읽고 오늘의 작업 현황을 Slack 채널에 업로드합니다.

## 사용법

사용자가 다음 정보를 제공합니다:
- **GitHub 레포지토리**: `owner/repo` 형식
- **Issue 번호**: 단일(`#12`) 또는 복수(`#12, #15, #20`) 또는 생략(오늘 업데이트된 이슈 자동 수집)
- **Slack 채널**: `#채널명` 또는 채널 ID

예시 요청:
> "JoNaYeon/repo의 #12, #15 이슈를 #daily-standup 채널에 올려줘"
> "오늘 작업한 이슈들 #general에 정리해줘"

---

## 실행 순서

### 1. 📌 GitHub Issues 조회

이슈 번호가 지정된 경우:
```bash
gh issue view {번호} --repo {owner/repo} --json number,title,state,body,labels,assignees,comments,updatedAt
```

이슈 번호가 없는 경우 (오늘 날짜 기준 자동 수집):
```bash
gh issue list --repo {owner/repo} --state all --json number,title,state,body,labels,assignees,updatedAt \
  --search "updated:>={오늘날짜}"
```

수집 항목:
- 이슈 번호, 제목, 상태 (open/closed)
- 본문 내용
- 레이블 (`bug`, `fix`, `feature`, `enhancement`, `todo`, `in-progress` 등)
- 담당자 (assignees)
- 최신 댓글

### 2. 🧠 이슈 분류 및 요약

수집한 이슈들을 아래 3가지 카테고리로 분류:

| 카테고리 | 분류 기준 |
|---|---|
| ✅ **금일 작업 사항** | `state: closed` 또는 오늘 닫힌 이슈, `done`/`completed` 레이블 |
| 🔧 **금일 수정 사항** | 레이블에 `bug`, `fix`, `hotfix`, `patch` 포함 |
| 📌 **진행중인 일정 (TODO)** | `state: open`, `in-progress`/`todo`/`pending` 레이블 또는 미완료 이슈 |

- 하나의 이슈가 여러 카테고리에 해당하면 가장 적합한 카테고리 하나에만 배치
- 각 이슈를 **한 줄**로 압축 요약

### 3. ✍️ Slack 메시지 미리보기

전송 전 사용자에게 아래 형식으로 미리보기를 보여주고 **승인 요청**:

```
━━━━━━━━━━━━━━━━━━━━━━━━━
📋 *Daily Report — YYYY.MM.DD (요일)*
레포지토리: owner/repo
━━━━━━━━━━━━━━━━━━━━━━━━━

✅ *금일 작업 사항*
• #12 로그인 기능 구현 — JWT 토큰 기반 인증 완료
• #15 메인 페이지 UI — 반응형 레이아웃 적용 완료

🔧 *금일 수정 사항*
• #18 로그아웃 버튼 오류 수정 — 세션 초기화 버그 fix

📌 *진행중인 일정 (TODO)*
• #20 알림 기능 — API 연동 중, 내일 완료 예정
• #22 테스트 코드 작성 — 단위 테스트 50% 완료

━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 4. 📤 Slack 채널 전송

사용자 승인 후 `slack_send_message`로 지정 채널에 전송.

---

## 주의사항
- **반드시** 전송 전 미리보기를 보여주고 승인 받기
- 이슈가 없는 카테고리는 `• 해당 없음` 표시
- 레이블이 없는 이슈는 제목과 상태(open/closed)로 카테고리 판단
- `gh` CLI가 인증되어 있어야 함 (`gh auth status`로 확인)
- GitHub CLI 경로: `/C/Program Files/GitHub CLI/gh`
