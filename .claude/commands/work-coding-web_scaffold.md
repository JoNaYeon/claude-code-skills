---
description: "Use this skill when the user wants to create a new web project from scratch with a title, role, and features. This skill generates a complete Flask + JS/HTML/CSS web application with GitHub repo, modular folder structure, AWS-ready config, and local dev support. Triggers on: 'make a website', 'create a web app', 'build a web project', 'scaffold a web app', '웹 만들어줘', '사이트 만들어줘', '웹 프로젝트 생성', '웹앱 만들어줘', '홈페이지 만들어줘'."
---

# Web Scaffold — 웹 프로젝트 자동 생성

## 목적
사용자가 **제목, 역할, 기능**을 알려주면, Flask + JavaScript/HTML/CSS 기반의 완성된 웹 프로젝트를 자동으로 구성하고 GitHub 레포에 업로드합니다.

## 기술 스택 (고정)
- **Backend**: Python 3.11+ / Flask
- **Frontend**: Vanilla JavaScript + HTML5 + CSS3
- **Template Engine**: Jinja2
- **Config**: JSON 기반 (`config.json`)
- **Deploy Target**: AWS (EC2/ECS) — 로컬에서도 즉시 실행 가능

---

## 지침

### Phase 1 — 요구사항 수집

사용자에게 다음 3가지를 확인합니다:

**1. 제목 (Title)**
> 프로젝트 이름이 무엇인가요?

**2. 역할 (Role)**
> 이 웹의 주요 역할은 무엇인가요?
> (예: 대시보드, 관리 페이지, 랜딩 페이지, CRUD 앱, API 서버 + 프론트 등)

**3. 기능 목록 (Features)**
> 필요한 기능을 나열해 주세요.
> (예: 로그인, 데이터 조회, 파일 업로드, 차트 표시, 검색 등)

추가 확인 (선택):
- DB 사용 여부 및 종류 (SQLite / PostgreSQL / DynamoDB 등)
- 인증 필요 여부 (로그인 / 공개)
- AWS 서비스 연동 계획 (S3, RDS, SES 등)

---

### Phase 2 — 프로젝트 생성

#### 2-1. GitHub 레포 생성

프로젝트명을 kebab-case로 변환하여 레포를 생성합니다.

```bash
mkdir <project-name>
cd <project-name>
git init
```

#### 2-2. 폴더 구조 생성

아래 구조를 반드시 따릅니다:

```
<project-name>/
├── config.json              # 환경 설정 (local/dev/prod)
├── app.py                   # Flask 앱 진입점
├── requirements.txt         # Python 의존성
├── .env.example             # 환경변수 템플릿
├── .gitignore
├── README.md
├── data/                    # 데이터 파일 (CSV, JSON 등)
│   └── .gitkeep
├── logs/                    # 로그 파일
│   └── .gitkeep
├── models/                  # 데이터 모델 / ORM 정의
│   ├── __init__.py
│   └── base_model.py
├── repositories/            # 데이터 접근 계층 (Repository 패턴)
│   ├── __init__.py
│   └── base_repo.py
├── routes/                  # Flask Blueprint 라우트
│   ├── __init__.py
│   └── main_routes.py
├── scripts/                 # 유틸리티 스크립트 (DB 초기화, 마이그레이션 등)
│   └── .gitkeep
├── services/                # 비즈니스 로직 계층
│   ├── __init__.py
│   └── base_service.py
├── static/                  # 정적 파일
│   ├── css/
│   │   └── styles.css
│   ├── js/
│   │   └── scripts.js
│   └── templates/           # Jinja2 HTML 템플릿
│       ├── base.html        # 레이아웃 마스터 (모든 페이지 상속)
│       ├── components/      # 재사용 컴포넌트 (header, footer, sidebar 등)
│       │   ├── header.html
│       │   ├── footer.html
│       │   └── sidebar.html
│       ├── pages/           # 개별 페이지
│       │   └── index.html
│       └── macros/          # Jinja2 매크로 (폼, 버튼, 테이블 등 재사용 블록)
│           └── forms.html
└── tests/                   # 테스트
    └── .gitkeep
```

---

### Phase 3 — 핵심 파일 작성

#### 3-1. `config.json` — 환경별 설정

```json
{
  "app": {
    "title": "<프로젝트 제목>",
    "role": "<역할>",
    "version": "0.1.0"
  },
  "environments": {
    "local": {
      "debug": true,
      "host": "127.0.0.1",
      "port": 5000,
      "database": {
        "type": "sqlite",
        "path": "data/local.db"
      },
      "static_url": "/static",
      "log_level": "DEBUG"
    },
    "dev": {
      "debug": true,
      "host": "0.0.0.0",
      "port": 5000,
      "database": {
        "type": "postgresql",
        "host": "${DB_HOST}",
        "port": 5432,
        "name": "${DB_NAME}",
        "user": "${DB_USER}",
        "password": "${DB_PASSWORD}"
      },
      "aws": {
        "region": "${AWS_REGION}",
        "s3_bucket": "${S3_BUCKET}"
      },
      "log_level": "INFO"
    },
    "prod": {
      "debug": false,
      "host": "0.0.0.0",
      "port": 8000,
      "database": {
        "type": "postgresql",
        "host": "${DB_HOST}",
        "port": 5432,
        "name": "${DB_NAME}",
        "user": "${DB_USER}",
        "password": "${DB_PASSWORD}"
      },
      "aws": {
        "region": "${AWS_REGION}",
        "s3_bucket": "${S3_BUCKET}"
      },
      "log_level": "WARNING"
    }
  }
}
```

#### 3-2. `app.py` — Flask 진입점

```python
import json
import os
import logging
from flask import Flask

def load_config(env=None):
    """config.json에서 환경별 설정 로드"""
    env = env or os.getenv("FLASK_ENV", "local")
    with open("config.json", "r", encoding="utf-8") as f:
        config = json.load(f)
    return {**config["app"], **config["environments"].get(env, {})}

def create_app(env=None):
    """Flask 앱 팩토리"""
    config = load_config(env)

    app = Flask(
        __name__,
        static_folder="static",
        template_folder="static/templates"
    )
    app.config.update(config)
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "dev-secret-change-me")

    # 로깅 설정
    logging.basicConfig(
        level=getattr(logging, config.get("log_level", "INFO")),
        format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler("logs/app.log", encoding="utf-8")
        ]
    )

    # Blueprint 등록
    from routes.main_routes import main_bp
    app.register_blueprint(main_bp)

    return app

if __name__ == "__main__":
    app = create_app()
    app.run(
        host=app.config.get("host", "127.0.0.1"),
        port=app.config.get("port", 5000),
        debug=app.config.get("debug", True)
    )
```

#### 3-3. `routes/main_routes.py` — 메인 라우트

```python
from flask import Blueprint, render_template

main_bp = Blueprint("main", __name__)

@main_bp.route("/")
def index():
    return render_template("pages/index.html", title="Home")

@main_bp.route("/health")
def health():
    return {"status": "ok"}, 200
```

사용자가 요청한 기능에 따라 추가 라우트를 생성합니다.
기능이 많으면 Blueprint를 분리합니다:
- `routes/auth_routes.py` — 인증 관련
- `routes/api_routes.py` — API 엔드포인트
- `routes/<feature>_routes.py` — 기능별 분리

#### 3-4. `repositories/base_repo.py` — 데이터 접근 베이스

```python
import json
import os
import sqlite3
from abc import ABC, abstractmethod

class BaseRepository(ABC):
    """Repository 패턴 베이스 클래스"""

    @abstractmethod
    def find_all(self):
        pass

    @abstractmethod
    def find_by_id(self, id):
        pass

    @abstractmethod
    def create(self, data):
        pass

    @abstractmethod
    def update(self, id, data):
        pass

    @abstractmethod
    def delete(self, id):
        pass


class SQLiteRepository(BaseRepository):
    """SQLite 기반 Repository (로컬 개발용)"""

    def __init__(self, db_path="data/local.db", table_name="items"):
        self.db_path = db_path
        self.table_name = table_name

    def _get_connection(self):
        conn = sqlite3.connect(self.db_path)
        conn.row_factory = sqlite3.Row
        return conn

    def find_all(self):
        conn = self._get_connection()
        cursor = conn.execute(f"SELECT * FROM {self.table_name}")
        rows = [dict(row) for row in cursor.fetchall()]
        conn.close()
        return rows

    def find_by_id(self, id):
        conn = self._get_connection()
        cursor = conn.execute(
            f"SELECT * FROM {self.table_name} WHERE id = ?", (id,)
        )
        row = cursor.fetchone()
        conn.close()
        return dict(row) if row else None

    def create(self, data):
        conn = self._get_connection()
        keys = ", ".join(data.keys())
        placeholders = ", ".join(["?"] * len(data))
        conn.execute(
            f"INSERT INTO {self.table_name} ({keys}) VALUES ({placeholders})",
            list(data.values())
        )
        conn.commit()
        conn.close()

    def update(self, id, data):
        conn = self._get_connection()
        set_clause = ", ".join([f"{k} = ?" for k in data.keys()])
        conn.execute(
            f"UPDATE {self.table_name} SET {set_clause} WHERE id = ?",
            list(data.values()) + [id]
        )
        conn.commit()
        conn.close()

    def delete(self, id):
        conn = self._get_connection()
        conn.execute(
            f"DELETE FROM {self.table_name} WHERE id = ?", (id,)
        )
        conn.commit()
        conn.close()
```

AWS 환경에서는 이 베이스를 상속하여 `DynamoDBRepository`, `PostgreSQLRepository` 등을 구현합니다.

#### 3-5. `static/templates/base.html` — 마스터 레이아웃

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}{{ config.get('title', 'App') }}{% endblock %}</title>

    <!-- Base CSS -->
    <link rel="stylesheet" href="{{ url_for('static', filename='css/styles.css') }}">

    <!-- Page-specific CSS -->
    {% block extra_css %}{% endblock %}
</head>
<body>
    {% include 'components/header.html' %}

    <div class="layout">
        {% block sidebar %}{% endblock %}

        <main class="content">
            {% with messages = get_flashed_messages(with_categories=true) %}
                {% if messages %}
                    {% for category, message in messages %}
                        <div class="alert alert--{{ category }}">{{ message }}</div>
                    {% endfor %}
                {% endif %}
            {% endwith %}

            {% block content %}{% endblock %}
        </main>
    </div>

    {% include 'components/footer.html' %}

    <!-- Base JS -->
    <script src="{{ url_for('static', filename='js/scripts.js') }}"></script>

    <!-- Page-specific JS -->
    {% block extra_js %}{% endblock %}
</body>
</html>
```

#### 3-6. `static/templates/pages/index.html`

```html
{% extends 'base.html' %}

{% block title %}Home — {{ config.get('title', 'App') }}{% endblock %}

{% block content %}
<section class="hero">
    <h1>{{ config.get('title', 'Welcome') }}</h1>
    <p>{{ config.get('role', '') }}</p>
</section>

<section class="features">
    <!-- 사용자 요청 기능에 따라 동적으로 생성 -->
</section>
{% endblock %}
```

#### 3-7. `static/templates/components/` — 재사용 컴포넌트

**header.html**
```html
<header class="header">
    <div class="header__logo">
        <a href="/">{{ config.get('title', 'App') }}</a>
    </div>
    <nav class="header__nav">
        {% block nav_items %}
        <a href="/" class="header__link">Home</a>
        {% endblock %}
    </nav>
</header>
```

**footer.html**
```html
<footer class="footer">
    <p>&copy; {{ now.year if now else '2026' }} {{ config.get('title', 'App') }}</p>
</footer>
```

**sidebar.html**
```html
<aside class="sidebar">
    {% block sidebar_content %}
    <nav class="sidebar__nav">
        <a href="/" class="sidebar__link">Home</a>
    </nav>
    {% endblock %}
</aside>
```

#### 3-8. `static/templates/macros/forms.html` — 재사용 매크로

```html
{# 텍스트 입력 필드 #}
{% macro input(name, label, type="text", value="", required=false, placeholder="") %}
<div class="form-group">
    <label class="form-label" for="{{ name }}">{{ label }}</label>
    <input class="form-input" type="{{ type }}" id="{{ name }}" name="{{ name }}"
           value="{{ value }}" placeholder="{{ placeholder }}"
           {% if required %}required{% endif %}>
</div>
{% endmacro %}

{# 셀렉트 드롭다운 #}
{% macro select(name, label, options, selected="", required=false) %}
<div class="form-group">
    <label class="form-label" for="{{ name }}">{{ label }}</label>
    <select class="form-select" id="{{ name }}" name="{{ name }}"
            {% if required %}required{% endif %}>
        <option value="">선택하세요</option>
        {% for opt in options %}
        <option value="{{ opt.value }}" {% if opt.value == selected %}selected{% endif %}>
            {{ opt.label }}
        </option>
        {% endfor %}
    </select>
</div>
{% endmacro %}

{# 제출 버튼 #}
{% macro submit_button(text="저장", variant="primary") %}
<button type="submit" class="btn btn--{{ variant }}">{{ text }}</button>
{% endmacro %}

{# 데이터 테이블 #}
{% macro data_table(headers, rows, id="data-table") %}
<div class="table-wrapper">
    <table class="table" id="{{ id }}">
        <thead>
            <tr>
                {% for h in headers %}
                <th>{{ h }}</th>
                {% endfor %}
            </tr>
        </thead>
        <tbody>
            {% for row in rows %}
            <tr>
                {% for cell in row %}
                <td>{{ cell }}</td>
                {% endfor %}
            </tr>
            {% endfor %}
        </tbody>
    </table>
</div>
{% endmacro %}
```

#### 3-9. `static/css/styles.css` — 모듈화된 CSS

```css
/* ============================================
   CSS Custom Properties (Design Tokens)
   모든 색상, 크기, 간격을 변수로 관리하여
   테마 변경 및 확장이 용이하도록 구성
   ============================================ */
:root {
    /* Colors */
    --color-primary: #2563eb;
    --color-primary-hover: #1d4ed8;
    --color-secondary: #64748b;
    --color-success: #16a34a;
    --color-warning: #d97706;
    --color-danger: #dc2626;
    --color-bg: #ffffff;
    --color-bg-secondary: #f8fafc;
    --color-text: #1e293b;
    --color-text-secondary: #64748b;
    --color-border: #e2e8f0;

    /* Typography */
    --font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, sans-serif;
    --font-size-xs: 0.75rem;
    --font-size-sm: 0.875rem;
    --font-size-base: 1rem;
    --font-size-lg: 1.125rem;
    --font-size-xl: 1.25rem;
    --font-size-2xl: 1.5rem;
    --font-size-3xl: 1.875rem;

    /* Spacing */
    --space-1: 0.25rem;
    --space-2: 0.5rem;
    --space-3: 0.75rem;
    --space-4: 1rem;
    --space-6: 1.5rem;
    --space-8: 2rem;
    --space-12: 3rem;

    /* Layout */
    --sidebar-width: 240px;
    --header-height: 60px;
    --content-max-width: 1200px;
    --border-radius: 6px;

    /* Shadows */
    --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
    --shadow-md: 0 4px 6px rgba(0,0,0,0.07);
}

/* ============================================
   Reset & Base
   ============================================ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { font-size: 16px; }
body {
    font-family: var(--font-family);
    color: var(--color-text);
    background: var(--color-bg);
    line-height: 1.6;
    min-height: 100vh;
}
a { color: var(--color-primary); text-decoration: none; }
a:hover { color: var(--color-primary-hover); }

/* ============================================
   Layout
   ============================================ */
.layout {
    display: flex;
    min-height: calc(100vh - var(--header-height));
}
.content {
    flex: 1;
    max-width: var(--content-max-width);
    margin: 0 auto;
    padding: var(--space-8);
}

/* ============================================
   Header
   ============================================ */
.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: var(--header-height);
    padding: 0 var(--space-8);
    background: var(--color-bg);
    border-bottom: 1px solid var(--color-border);
    position: sticky;
    top: 0;
    z-index: 100;
}
.header__logo a { font-size: var(--font-size-xl); font-weight: 700; color: var(--color-text); }
.header__nav { display: flex; gap: var(--space-6); }
.header__link { color: var(--color-text-secondary); font-size: var(--font-size-sm); }
.header__link:hover { color: var(--color-primary); }

/* ============================================
   Sidebar
   ============================================ */
.sidebar {
    width: var(--sidebar-width);
    background: var(--color-bg-secondary);
    border-right: 1px solid var(--color-border);
    padding: var(--space-6);
    flex-shrink: 0;
}
.sidebar__nav { display: flex; flex-direction: column; gap: var(--space-2); }
.sidebar__link {
    display: block;
    padding: var(--space-2) var(--space-3);
    border-radius: var(--border-radius);
    color: var(--color-text-secondary);
    font-size: var(--font-size-sm);
}
.sidebar__link:hover { background: var(--color-border); color: var(--color-text); }

/* ============================================
   Footer
   ============================================ */
.footer {
    padding: var(--space-6) var(--space-8);
    text-align: center;
    color: var(--color-text-secondary);
    font-size: var(--font-size-sm);
    border-top: 1px solid var(--color-border);
}

/* ============================================
   Components: Buttons
   ============================================ */
.btn {
    display: inline-flex;
    align-items: center;
    gap: var(--space-2);
    padding: var(--space-2) var(--space-4);
    border: none;
    border-radius: var(--border-radius);
    font-size: var(--font-size-sm);
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.btn--primary { background: var(--color-primary); color: #fff; }
.btn--primary:hover { background: var(--color-primary-hover); }
.btn--secondary { background: var(--color-bg-secondary); color: var(--color-text); border: 1px solid var(--color-border); }
.btn--danger { background: var(--color-danger); color: #fff; }

/* ============================================
   Components: Forms
   ============================================ */
.form-group { margin-bottom: var(--space-4); }
.form-label { display: block; margin-bottom: var(--space-1); font-size: var(--font-size-sm); font-weight: 500; }
.form-input, .form-select {
    width: 100%;
    padding: var(--space-2) var(--space-3);
    border: 1px solid var(--color-border);
    border-radius: var(--border-radius);
    font-size: var(--font-size-base);
}
.form-input:focus, .form-select:focus {
    outline: none;
    border-color: var(--color-primary);
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

/* ============================================
   Components: Table
   ============================================ */
.table-wrapper { overflow-x: auto; }
.table { width: 100%; border-collapse: collapse; }
.table th, .table td {
    padding: var(--space-3) var(--space-4);
    text-align: left;
    border-bottom: 1px solid var(--color-border);
}
.table th { font-size: var(--font-size-sm); font-weight: 600; background: var(--color-bg-secondary); }
.table tr:hover td { background: var(--color-bg-secondary); }

/* ============================================
   Components: Alert
   ============================================ */
.alert {
    padding: var(--space-3) var(--space-4);
    border-radius: var(--border-radius);
    margin-bottom: var(--space-4);
    font-size: var(--font-size-sm);
}
.alert--success { background: #f0fdf4; color: var(--color-success); border: 1px solid #bbf7d0; }
.alert--warning { background: #fffbeb; color: var(--color-warning); border: 1px solid #fde68a; }
.alert--error   { background: #fef2f2; color: var(--color-danger);  border: 1px solid #fecaca; }
.alert--info    { background: #eff6ff; color: var(--color-primary); border: 1px solid #bfdbfe; }

/* ============================================
   Components: Card
   ============================================ */
.card {
    background: var(--color-bg);
    border: 1px solid var(--color-border);
    border-radius: var(--border-radius);
    padding: var(--space-6);
    box-shadow: var(--shadow-sm);
}
.card__title { font-size: var(--font-size-lg); font-weight: 600; margin-bottom: var(--space-3); }
.card__body { color: var(--color-text-secondary); }

/* ============================================
   Hero Section
   ============================================ */
.hero {
    text-align: center;
    padding: var(--space-12) 0;
}
.hero h1 { font-size: var(--font-size-3xl); margin-bottom: var(--space-4); }
.hero p { font-size: var(--font-size-lg); color: var(--color-text-secondary); }

/* ============================================
   Responsive
   ============================================ */
@media (max-width: 768px) {
    .sidebar { display: none; }
    .content { padding: var(--space-4); }
    .header { padding: 0 var(--space-4); }
}
```

#### 3-10. `static/js/scripts.js` — 모듈화된 JS

```javascript
/**
 * App — 메인 애플리케이션 유틸리티
 * 모든 페이지에서 공통으로 사용하는 함수를 네임스페이스로 관리합니다.
 */
const App = {
    /**
     * API 호출 래퍼 (fetch + JSON + 에러 처리)
     */
    async api(endpoint, options = {}) {
        const defaults = {
            headers: { "Content-Type": "application/json" },
        };
        const config = { ...defaults, ...options };

        if (config.body && typeof config.body === "object") {
            config.body = JSON.stringify(config.body);
        }

        try {
            const response = await fetch(endpoint, config);
            if (!response.ok) {
                const error = await response.json().catch(() => ({}));
                throw new Error(error.message || `HTTP ${response.status}`);
            }
            return await response.json();
        } catch (err) {
            console.error(`[API Error] ${endpoint}:`, err);
            App.toast(err.message, "error");
            throw err;
        }
    },

    /**
     * 토스트 알림
     */
    toast(message, type = "info", duration = 3000) {
        const container = document.getElementById("toast-container")
            || App._createToastContainer();
        const toast = document.createElement("div");
        toast.className = `alert alert--${type}`;
        toast.textContent = message;
        toast.style.cssText = "animation: fadeIn 0.3s; margin-bottom: 8px;";
        container.appendChild(toast);
        setTimeout(() => {
            toast.style.animation = "fadeOut 0.3s";
            setTimeout(() => toast.remove(), 300);
        }, duration);
    },

    _createToastContainer() {
        const container = document.createElement("div");
        container.id = "toast-container";
        container.style.cssText =
            "position:fixed;top:20px;right:20px;z-index:9999;max-width:360px;";
        document.body.appendChild(container);
        return container;
    },

    /**
     * DOM Ready
     */
    ready(fn) {
        if (document.readyState !== "loading") fn();
        else document.addEventListener("DOMContentLoaded", fn);
    },

    /**
     * 이벤트 위임 (동적 요소 지원)
     */
    on(parent, event, selector, handler) {
        const el = typeof parent === "string" ? document.querySelector(parent) : parent;
        if (!el) return;
        el.addEventListener(event, (e) => {
            const target = e.target.closest(selector);
            if (target && el.contains(target)) handler.call(target, e);
        });
    },

    /**
     * 간단한 상태 관리
     */
    state: new Proxy({}, {
        set(target, key, value) {
            const old = target[key];
            target[key] = value;
            document.dispatchEvent(
                new CustomEvent("state:change", { detail: { key, value, old } })
            );
            return true;
        }
    })
};

/* 초기화 */
App.ready(() => {
    console.log("[App] Ready");
});
```

#### 3-11. 기타 필수 파일

**requirements.txt**
```
flask>=3.0
python-dotenv>=1.0
gunicorn>=21.0
```

**.env.example**
```
FLASK_ENV=local
SECRET_KEY=change-me-in-production
# AWS (prod/dev only)
AWS_REGION=ap-northeast-2
S3_BUCKET=
DB_HOST=
DB_NAME=
DB_USER=
DB_PASSWORD=
```

**.gitignore**
```
__pycache__/
*.pyc
.env
*.db
logs/*.log
data/*.db
venv/
.vscode/
.idea/
node_modules/
```

**services/base_service.py**
```python
class BaseService:
    """서비스 계층 베이스 클래스. Repository를 주입받아 비즈니스 로직을 처리합니다."""

    def __init__(self, repository):
        self.repo = repository

    def get_all(self):
        return self.repo.find_all()

    def get_by_id(self, id):
        return self.repo.find_by_id(id)

    def create(self, data):
        return self.repo.create(data)

    def update(self, id, data):
        return self.repo.update(id, data)

    def delete(self, id):
        return self.repo.delete(id)
```

**models/base_model.py**
```python
from dataclasses import dataclass, asdict
from datetime import datetime

@dataclass
class BaseModel:
    """모델 베이스 클래스. 모든 엔티티가 상속합니다."""
    id: int = None
    created_at: str = None
    updated_at: str = None

    def __post_init__(self):
        now = datetime.utcnow().isoformat()
        if not self.created_at:
            self.created_at = now
        self.updated_at = now

    def to_dict(self):
        return asdict(self)
```

---

### Phase 4 — 기능별 코드 생성

사용자가 요청한 **기능 목록**에 따라 추가 파일을 생성합니다.

각 기능에 대해:
1. **Route** (`routes/<feature>_routes.py`) — 엔드포인트 정의
2. **Service** (`services/<feature>_service.py`) — 비즈니스 로직
3. **Repository** (`repositories/<feature>_repo.py`) — 데이터 접근
4. **Model** (`models/<feature>.py`) — 데이터 모델
5. **Template** (`static/templates/pages/<feature>.html`) — UI 페이지
6. **JS** (필요시 `static/js/<feature>.js`) — 프론트 로직

기능 예시별 생성 패턴:
- **로그인** → auth_routes + auth_service + user model + login.html
- **데이터 조회** → api_routes + data_service + data_repo + list.html + detail.html
- **파일 업로드** → upload_routes + upload_service + S3 연동 코드
- **차트** → chart 데이터 API + chart.html + chart.js (Chart.js CDN)

---

### Phase 5 — README 작성 및 Git 업로드

README.md를 자동 생성합니다:
- 프로젝트 설명 (제목 + 역할)
- 기술 스택
- 로컬 실행 방법 (`pip install -r requirements.txt && python app.py`)
- 폴더 구조 설명
- 환경변수 설정 안내
- AWS 배포 가이드 (요약)
- 기능 목록

```bash
git add .
git commit -m "feat: scaffold <project-name> — <역할>"
git remote add origin <repo-url>
git push -u origin master
```

---

## 출력 형식

```markdown
## 프로젝트 생성 완료 ✅

- **프로젝트**: <제목>
- **역할**: <역할>
- **레포**: https://github.com/<user>/<project-name>
- **실행 방법**:
  \`\`\`bash
  cd <project-name>
  pip install -r requirements.txt
  python app.py
  # → http://127.0.0.1:5000
  \`\`\`

### 생성된 기능
| 기능 | 라우트 | 페이지 |
|------|--------|--------|
| 홈 | `/` | pages/index.html |
| 헬스체크 | `/health` | JSON 응답 |
| ... | ... | ... |

### 다음 단계
1. `.env` 파일 생성 및 환경변수 설정
2. 기능별 상세 구현
```

## 참고사항
- 모든 HTML은 `base.html`을 상속합니다. 새 페이지 추가 시 `{% extends 'base.html' %}` 사용.
- CSS는 BEM 네이밍 (`block__element--modifier`)과 CSS Custom Properties를 사용합니다.
- JS는 `App` 네임스페이스 하위에 기능을 추가합니다.
- 재사용 가능한 UI는 `components/` (HTML 조각) 또는 `macros/` (Jinja2 매크로)에 배치합니다.
- AWS 전환 시 `config.json`의 환경만 변경하면 됩니다. 코드 수정 최소화.
