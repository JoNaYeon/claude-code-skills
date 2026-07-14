# DB·망 분리 — SEEMEDI 특이

> **SEEMEDI 특이** — 병원망/회사망 분리, 하이브리드 인프라 때문에 존재.
> 출처: `STD-STACK-0001` §3.5~3.8, `STD-TERM-0001` §5.2·§7.1.
> General 인프라·DB 명명: [../../general/by-task/aws-infra-setup.md](../../general/by-task/aws-infra-setup.md) · [naming-conventions.md](../../general/by-task/naming-conventions.md)

## 식별 온프레미스 / 운영 AWS 분리

- **식별 데이터(PHI) = 온프레미스(병원망)**, **운영 = AWS**. PostgreSQL은 공유 Aurora + 스키마/role 분리.
- 인프라는 **하이브리드**: Kubernetes AWS=**EKS** / 온프레미스=**K3s**.
- 온프레미스(병원망) 리소스는 `-onprem` 세그먼트 또는 별도 네임스페이스로 구분(MUST). **PHI 취급 구간은 클라우드 반출 금지.**

## HSM (온프레미스 키)

- 매핑 키·복호화 키는 **온프레미스 HSM에만**. 병원망 비반출(MUST).
- HSM 준수 규격: **FIPS 140-3 Level 3+**, Common Criteria(EN 419221-5), **PKCS#11**. 국내 공공·의료 연계 시 KCMVP 해당성 RA/QA 확인.

## 데이터 계층 (raw/anon 2계층)

- 폐쇄망→외부망은 **익명화(anon) 데이터만** 이관. raw PII·salt·id_mapping은 폐쇄망 불변.
- 공통 스키마 네임스페이스: `raw` / `anon` / `code` / `meta` / `audit`.
- 분류값(status/type)은 참조 **코드테이블 `code.*`** 사용, PostgreSQL ENUM 미사용.
- uid = `bigint GENERATED ALWAYS AS IDENTITY`(순차).

## PHI 컬럼 표식

- PHI 컬럼은 민감도 **L4**로 분류하고 컬럼 코멘트에 **`-- PHI L4`** 표식(MUST).
- 공통 감사 컬럼: `created_at`/`updated_at`/`created_by`/`is_deleted`(소프트 삭제) — General 규칙과 동일.

## 저장·클라이언트 통제

- S3 + Object Lock: 감사 로그 WORM + 해시 체이닝, 저장 데이터 가명화+암호화 이중보호.
- Redis: PHI 원본 저장 금지(휘발성).
- DBeaver로 DB 조회 시 최소권한 계정, **PHI 직접 조회 통제·감사**(병원망 DB 접속은 승인·기록).

## GitLab/소스 (폐쇄망)

- GitLab self-hosted, **AWS 서울(ap-northeast-2) 프라이빗 VPC**. 프라이빗 서브넷·퍼블릭 ingress 차단·VPN/Direct Connect·Keycloak SSO. **소스/CI는 PHI 미포함.**
