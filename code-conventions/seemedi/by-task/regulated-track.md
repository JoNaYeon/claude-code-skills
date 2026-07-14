# 규제 트랙 (IEC 62304) — SEEMEDI 특이

> **SEEMEDI 특이** — 의료기기 소프트웨어 규제 때문에 존재.
> 출처: `STD-GOV-0001`, `STD-REPO-0001`, `STD-TOOL-0001` §6, `STD-GIT-0001` §7, `STD-VER-0001` §5.
> General 저장소·툴체인·Git: [../../general/by-task/repo-and-versioning.md](../../general/by-task/repo-and-versioning.md)

## 거버넌스 판정 축

- **1차 트리거 = 의료기기 여부.** 의료기기 → `track: regulated`(IEC 62304), 비의료기기 → `track: fast`.
- 보안·데이터·네트워크는 판정축이 아니라 **기능영역 태그**(domains).

## governance.yaml (레포 루트 1개, MUST)

```yaml
track: regulated               # regulated | fast (의료기기=regulated)
iec62304_class: C              # regulated만 필수. A/B/C. 레포명엔 넣지 않음
product:
  code: P2026-001
  short: ECG
  name: ECGmentor
domains: [data, security, integration]   # 기능영역 태그
```

- CI가 `track`/`iec62304_class`/`product`/`domains` 존재·형식을 강제(누락 시 fail).

## 레포 경계 = 규제 경계

- 규제 제품 레포(`ecg-*`, `edo-*`)는 **레포 전체가 regulated**, 하나의 레포 = 하나의 IEC 62304 심사 단위.
- 옛 디렉터리 격리(`regulated/`·`nonregulated/`)는 폐기 → **레포 격리**.
- **단방향 의존**: 규제→비규제 공유lib(하향) 허용, 비규제→규제(상향) 금지, 규제 레포 간 소스 의존 금지.
- 공유lib가 규제 제품에 소비되면 그 lib는 **규제 대상으로 취급**(CODEOWNERS에 QMS 공동).

## 제품·트랙 매핑

| 제품 | 약칭 | 레포 | track |
|------|:---:|------|-------|
| ECGmentor | ECG | `ecg-*` | regulated |
| Endomentor | EDO | `edo-*` | regulated |
| Healthmentor | HEL | `hel-*` | fast ※재인증 시 승격 |
| Talkmentor | TLK | `tlk-*` | fast ※SaMD 판정 대상 |

## 트랙 차등 게이트

| 항목 | regulated | fast |
|------|-----------|------|
| 정적분석 경고 | **0 (fail)** | 허용(에러만 차단) |
| 공개 API 문서화 | MUST(누락 시 CI 차단) | SHOULD |
| 에러 경로 테스트 | 필수 + 커버리지 게이트 | 권장 |
| MR 승인 | **2인 이상, self-approve 금지**, QMS 공동 | 1인 MAY |
| 추적성 토큰 | 커밋·MR에 `Refs REQ-ECG-0012` 필수 | 미적용 |
| 로그 보존 | 규정 보존기간 + 변조방지(무결성) | 운영 정책 |
| 감사 로그 | 안전 관련 이벤트 감사 추적 MUST | 일반 |
| SBOM | 첨부 MUST | SHOULD |
| pre-commit `--no-verify` | **금지(MUST NOT)** | 정책상 금지(SHOULD NOT) |

## 버전·재인증

- 의료기기 중대변경(재인증)은 해당 축 **MAJOR 승격** + IEC 62304 변경영향분석 게이트 통과 후 태깅.
  - 모델·알고리즘 실질 변경 → 코드 MAJOR / 외부 계약 파괴 → API MAJOR(`/v2`) / 학습 데이터 실질 변경 → 데이터셋 MAJOR.
- regulated 레포 변경 또는 의존 공유lib 새 버전 채택 시 **재검증(re-validation)** job 실행.
- 추적성 SSOT: `REQ-{제품약칭}-{4자리}`(+RISK/TC). GitLab은 관리엔진(Issue 번호를 SSOT로 쓰지 않음).
