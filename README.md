# 🧐 dbt Analytics Engineering Certification — Study Repo

This repository exists to **track, organize, and reinforce my study process** for the **dbt Analytics Engineering Certification Exam**.

At this stage, the repo is intentionally lightweight. It is not meant to represent a finished analytics project yet — it is a **living study notebook** that will evolve as I work through the exam domains, exercises, and reference material.

Over time, this README (and the repo itself) will be updated with examples, notes, and implementations as concepts move from *theory → practice*.

---

## 🎯 Purpose of This Repository

* Centralize study notes for the dbt Analytics Engineering Certification
* Map **exam objectives → concrete concepts → dbt features**
* Create space for small experiments, examples, and reference models
* Act as a revision aid before sitting for the exam

This repo is **not** intended to be production-ready dbt code (yet). The focus is understanding *why* things work the way they do before optimizing *how* they’re built.

---

## 📚 Exam Topics Covered (with dbt Docs Links)

All links below point directly to **official dbt documentation** so this README can function as a single, consolidated navigation hub while studying.

---

### 1. Analytics Engineering Foundations

Core concepts behind analytics engineering and dbt’s role in the modern data stack.

* [What is analytics engineering?](https://docs.getdbt.com/docs/introduction/analytics-engineering)
* [Why dbt?](https://docs.getdbt.com/docs/introduction/why-dbt)
* [ELT vs ETL](https://docs.getdbt.com/docs/introduction/etl-vs-elt)
* [The modern data stack](https://docs.getdbt.com/docs/introduction/data-stack)

---

### 2. dbt Project Structure & Configuration

How a dbt project is organized and configured.

* [dbt project structure](https://docs.getdbt.com/docs/build/projects)
* [`dbt_project.yml`](https://docs.getdbt.com/reference/dbt_project.yml)
* [Models](https://docs.getdbt.com/docs/build/models)
* [Model configurations](https://docs.getdbt.com/reference/model-configs)
* [Materializations](https://docs.getdbt.com/docs/build/materializations)
* [Configuration precedence](https://docs.getdbt.com/reference/configs-and-properties)

---

### 3. Sources, Seeds, and Snapshots

How dbt ingests and manages upstream data.

* [Sources](https://docs.getdbt.com/docs/build/sources)
* [Source freshness](https://docs.getdbt.com/docs/build/sources#source-freshness)
* [Seeds](https://docs.getdbt.com/docs/build/seeds)
* [Snapshots](https://docs.getdbt.com/docs/build/snapshots)
* [Snapshot strategies](https://docs.getdbt.com/docs/build/snapshots#snapshot-strategies)

---

### 4. Models & Transformations

How transformations are written and organized in dbt.

* [Developing models](https://docs.getdbt.com/docs/build/models)
* [Staging, intermediate, and marts](https://docs.getdbt.com/docs/build/models#modeling-best-practices)
* [`ref()` and the DAG](https://docs.getdbt.com/reference/dbt-jinja-functions/ref)
* [Jinja in dbt](https://docs.getdbt.com/docs/build/jinja-macros)
* [Model contracts](https://docs.getdbt.com/docs/build/contracts)

---

### 5. Testing & Data Quality

Ensuring correctness and trust in analytics models.

* [Testing overview](https://docs.getdbt.com/docs/build/tests)
* [Generic tests](https://docs.getdbt.com/docs/build/tests#generic-tests)
* [Singular tests](https://docs.getdbt.com/docs/build/tests#singular-tests)
* [Built-in tests](https://docs.getdbt.com/reference/resource-properties/tests)
* [Custom tests](https://docs.getdbt.com/docs/build/tests#custom-tests)

---

### 6. Documentation & Exposures

Making analytics work discoverable and understandable.

* [Documentation overview](https://docs.getdbt.com/docs/build/documentation)
* [Schema files](https://docs.getdbt.com/docs/build/schemas)
* [dbt Docs site](https://docs.getdbt.com/docs/build/documentation#dbt-docs)
* [Exposures](https://docs.getdbt.com/docs/build/exposures)

---

### 7. Macros & Jinja

Reusable logic and abstraction in dbt.

* [Macros](https://docs.getdbt.com/docs/build/jinja-macros#macros)
* [Jinja basics](https://docs.getdbt.com/docs/build/jinja-macros#jinja-basics)
* [Adapter dispatch](https://docs.getdbt.com/docs/build/jinja-macros#adapter-dispatch)
* [Using variables](https://docs.getdbt.com/reference/dbt-jinja-functions/var)

---

### 8. Environments, Runs, and Deployments

How dbt is executed across environments.

* [dbt commands](https://docs.getdbt.com/reference/dbt-commands)
* [`dbt build`](https://docs.getdbt.com/reference/dbt-commands/build)
* [Profiles and targets](https://docs.getdbt.com/docs/core/connect-data-platform/profiles.yml)
* [State-based selection](https://docs.getdbt.com/reference/node-selection/state-comparison)
* [Deferral](https://docs.getdbt.com/reference/node-selection/defer)

---

### 9. Performance & Optimization

Making dbt projects scale.

* [Incremental models](https://docs.getdbt.com/docs/build/incremental-models)
* [Ephemeral models](https://docs.getdbt.com/docs/build/materializations#ephemeral)
* [Performance considerations](https://docs.getdbt.com/docs/guides/performance)

---

### 10. dbt Cloud Concepts (Conceptual)

High-level understanding of dbt Cloud features.

* [dbt Cloud overview](https://docs.getdbt.com/docs/cloud/about-dbt-cloud)
* [Jobs and schedules](https://docs.getdbt.com/docs/cloud/jobs)
* [Environments](https://docs.getdbt.com/docs/cloud/environments)
* [Continuous integration](https://docs.getdbt.com/docs/cloud/continuous-integration)

---

## 🗂 Planned Repository Evolution

As study progresses, this repo will gradually include:

* Annotated example models
* Small dbt project scaffolds
* Notes embedded directly alongside code
* Diagrams where concepts benefit from visualization

[Study Task Progress can be monitored in Notion.](https://www.notion.so/dbt-Analytics-Engineer-Certification-2f08a72528aa8032b59fcb804ba04879?source=copy_link)

---

## 🔖 Reference

All topics and links are sourced directly from the **official dbt documentation** and the **dbt Analytics Engineering Certification Study Guide**.

---

## 🚧 Status

**Early study phase** — structure first, implementation to follow.
