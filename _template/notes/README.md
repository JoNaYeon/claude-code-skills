# Brain Vault Note Templates Staging

> 이 폴더는 실제 Brain Vault에 넣을 note template 후보를 먼저 버전 관리하는 staging 공간이다.

목표 경로:
- `<your-vault>/_templates/notes/`

분리 원칙:
- `_templates/ai/`: 스킬 운영, archetype, evaluation, local skill draft
- `_templates/notes/`: 실제 노트 생성 템플릿

현재 포함된 템플릿:
- `00_Knowledge Note.md`
- `01_Scrap.md`
- `02_Daily Log.md`
- `03_Taste Note.md`
- `04_Idea.md`
- `05_Topic.md`

운영 규칙:
- frontmatter schema 변경이 있으면 이 staging본부터 수정한다
- Brain API나 Dashboard가 새 필드를 요구하면 템플릿과 `CONTEXT.md` 요약을 함께 점검한다
- 실제 Vault 동기화는 합의 후 수행한다

Templater 메모:
- 날짜 필드는 Obsidian Templater 기준 `<% tp.date.now("YYYY-MM-DD") %>` 문법을 사용한다
- 제목은 가능한 한 파일명을 기준으로 `# <% tp.file.title %>` 형태로 시작한다
- 실제 Vault에 반영할 때도 staging본과 동일한 문법을 유지한다
