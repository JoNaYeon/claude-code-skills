# 의료 도메인 용어 (FHIR) — SEEMEDI 특이

> 📜 Governed by [`_init`](../../../_init/README.md) — 최고 규칙 계층. 충돌 시 _init 우선.

> **SEEMEDI 특이** — 의료 도메인 용어. 일반 프로젝트엔 없음.
> 출처: `STD-TERM-0001` §2 (FHIR R4 / KR Core IG v2.0.0 정렬).

## 원칙

- 도메인 용어는 **FHIR R4 / KR Core IG v2.0.0** 리소스명에 정렬. FHIR 부재 영역(STT·번역)은 사내 표준 정의.
- 코드값은 LOINC / SNOMED CT / RadLex 1차, 국내 규제보고는 KOSTOM 병기.

## 핵심 3개 용어 (소견/검사/판독)

| 한글 | 영문 코드명 | FHIR 리소스 | 주의 |
|------|-----------|-------------|------|
| 소견 | `finding` | Observation | AI/사람 관측 1건. **`interpretation` 필드명 금지** |
| 검사(오더) | `order` | ServiceRequest | 지시/처방 |
| 검사(영상) | `imagingStudy` | ImagingStudy | 촬영 영상 스터디 |
| 검사(시술) | `procedure` | Procedure | 수행된 행위(내시경 등) |
| 판독(산출물) | `report` | DiagnosticReport | 판독 결과 문서 전체 |
| 판독(결론) | `conclusion` | DiagnosticReport.conclusion | **`interpretation` 대체어** |

- '검사'는 order/imagingStudy/procedure로 **3분리**(MUST).
- '판독'은 FHIR `Observation.interpretation`(예약어)과 충돌 → 코드 필드명으로 `interpretation` **금지(MUST NOT)**, `conclusion`/`report` 사용.
- 라디오로지 사슬: ServiceRequest → ImagingStudy → Observation → DiagnosticReport.

## 추가 용어

| 한글 | 코드명 | 비고 |
|------|--------|------|
| 환자 | `patient` (Patient) | 회사망에선 비식별/합성만 |
| 판독의 | `reader` (Practitioner role=reader) | `interpreter` 아님 |
| 확신도 | `confidence` (0.0~1.0) | `probability`와 구분 |
| 추론 | `inference` | 모델 예측 1회 실행 |
| 학습 | `training` | 모델 학습 런 |
| 단위 | `unit` | UCUM 강제 |

## STT·번역 (Talkmentor, FHIR 부재 → 사내 표준)

| 한글 | 코드명 | 비고 |
|------|--------|------|
| 전사(轉寫) | `transcript` | STT 결과 텍스트. DocumentReference type=transcript |
| 전사 구간 | `transcriptSegment` | 타임스탬프 발화 조각 |
| 번역 | `translation` | 원문→대상어 |
| 원본언어 | `sourceLanguage` (BCP 47) | ko-KR. `srcLang` 축약 금지 |
| 대상언어 | `targetLanguage` (BCP 47) | en-US. `tgtLang` 축약 금지 |
| 화자 | `speaker` | diarization 식별자 |

## 교차 관심사 도메인 토큰 (에러코드용)

- 업무 실패는 업무 도메인(order/report/finding) 우선. 귀속 안 되면: `auth`(인증·인가 401/403), `infra`(DB/네트워크/직렬화 500).
- 에러코드 도메인 토큰은 대문자: `order`→`ORDER`.
