# dbt-codegen ⚡️ — Stop Hand-Writing Boilerplate, Start Shipping Models

The [`dbt-labs/codegen`](https://github.com/dbt-labs/dbt-codegen) package is a set of macros that **generate dbt code** (SQL + YAML) and **print it to your terminal**, ready to copy/paste into your project. Think of it as: *“I refuse to type repetitive YAML ever again.”* 😌🧠

Use it to accelerate:
- **Source onboarding** (`sources.yml`) 📦
- **Staging model scaffolding** (`stg__*.sql`) 🧱
- **Model YAML** generation (`schema.yml` / model docs + column lists) 📝

---

## Why engineers should use dbt-codegen 💥

### ✅ Less time on boilerplate
Most dbt projects die a slow death from “I’ll document it later.” Codegen makes “later” basically **now**.

### ✅ More consistent patterns
Standardized sources + staging models + schema YAML = fewer one-off styles, fewer review comments, fewer “why is this different?” moments 🫠

### ✅ Faster onboarding for new datasets
When you’re onboarding 20+ tables (hello, nonprofit CRMs & fundraising platforms 👋), codegen reduces the setup to a repeatable workflow instead of a weekend-long YAMLathon.

---

## Quick links 🔗

- GitHub repo: https://github.com/dbt-labs/dbt-codegen
- dbt Hub package page: https://hub.getdbt.com/dbt-labs/codegen/latest/
- dbt packages overview: https://docs.getdbt.com/docs/build/packages
- `dbt deps` command reference: https://docs.getdbt.com/reference/commands/deps

---

## Installation 🧩

Add the package to `packages.yml`:

```yml
packages:
  - package: dbt-labs/codegen
    version: 0.14.0  # check dbt Hub for latest compatible version
```