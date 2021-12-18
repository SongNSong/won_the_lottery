# won_the_lottery

A new Flutter project.

## Commit Message Convention

### Basic Concept

```text
type: subject

body

footer
```

- feat: a new feature
- fix: a bug fix
- docs: change to documentation
- style: formatting, missing semi colons, etc; no code change
- refactor: refactoring production code
- test: adding tests, refactoring test; no production code change
- chore: updating build tasks, package manager, configs, etc; no production code change

#### 제목(Subject)

제목은 50자를 넘기지 않고, 문장의 끝에 마침표를 넣지 않는다. 커밋 메시지에는 과거시제를 사용하지 않고, 명령어로 작성하도록 합니다.

```text
feat: Summarize changes in around 50 characters or less
```

#### 본문(Body)

커밋 본문 내용은 선택사항이기 때문에 모든 커밋에 본문 내용을 작성할 필요는 없습니다. 타이틀 외에 추가적으로 정보를 전달하고 싶을 경우 추가적인 정보를 기입하면 됩니다.

#### 푸터(Footer)

푸터도 본문과 같이 선택사항이며 보통 이슈를 추적하기 위해 이슈 ID를 넣어주는 용도로 사용합니다. Pull Request의 설명이나 Commit Message에 지원되는 아래의
키워드를 함께 사용해서 Issue Number 와 연결하여 사용할 수 있습니다.

- close
- closes
- closed
- fix
- fixes
- fixed
- resolve
- resolves
- resolved

### Example

```text
feat: 상세페이지 ThumbnailList 컴포넌트에 무한 스크롤 추가

2021.12.18 x의 기획 요구사항 변경으로 인해 상세페이지 ThumbnailList 컴포넌트 기능 변경

Resolves: #123
```
