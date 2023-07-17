# MC3-Team3-GrayMa
MC3 그래 임마! 팀 입니다.

---

# 📌 Commit Style Guide

```
- [FEAT] : 새로운 기능 구현
- [ADD] : 부수적인 코드 추가, 라이브러리 추가, 에셋 추가, 새로운 View 생성
- [CHORE] : 코드 수정, 내부 파일 수정, 주석
- [CORRECT] : 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용
- [DEL] : 쓸모없는 코드 삭제
- [DOCS] : README나 WIKI 등의 문서 개정
- [FIX] : 버그, 오류 해결
- [REFACTOR] : 전면 수정이 있을 때 사용
- [MOVE] : 프로젝트 내 파일이나 코드의 이동
- [RENAME] : 파일 이름 변경이 있을 때 사용
- [SETTING] : 초기 세팅
```

- Prefix는 대문자로 작성한다.
- Description에 마침표(.)를 사용하지 않는다.
- `[<PREFIX>] <Description>(#<Issue-number>)` 양식을 준수한다.
    
    ```
    [<PREFIX>] <Description>(#<Issue-number>)
    ex) [CHORE] 버튼 레이아웃 수정(#37)
    ```
    

---

# 📌 Issue Style Guide

- Commit Style Guide와 동일한 Prefix를 사용하여 `[<PREFIX>] <Description>` 양식을 준수한다.
    
    ```
    [<PREFIX>] <Description>
    ex) [FEAT] 연락처 연동 기능 구현
    ```
    
- Issue 템플릿에 맞춰 작성한다.

---

# 📌 Pull Request Style Guide

- PR 제목은 이슈와 동일한 양식을 적용한다.
- PR 템플릿의 체크리스트를 확인한다.
- 본인 PR은 본인이 Merge 한다.
- Merge가 완료된 브랜치는 다시 사용하지 않는다면 삭제한다.

---

# 📌 브랜치 전략

- 브랜치는 `feat/<이슈번호>-<기능명>-<세부기능>` 으로 생성한다.

  ```
  feat/<이슈번호>-<기능명>-<세부기능>
  ex) feat/53-MyStrengthView-ui
  ```

### 🖇️ 브랜치 규칙

```
1. develop, main 브랜치에서의 작업은 원칙적으로 금지한다.
2. 자신이 담당한 부분 이외에 다른 팀원이 담당한 부분을 수정할 때에는 반드시 변경 사항을 전달한다.
3. 본인의 Pull Request는 본인이 Merge한다.
5. Commit, Push, Merge, Pull Request 등 모든 작업은 앱이 정상적으로 실행되는 지 빌드한 후 수행한다.
```

### 🖇️ 브랜치 플로우

```
1. Issue를 생성한다.
2. feature 브랜치를 생성한다.
3. feature 브랜치 내부에서 Add - Commit - Push - Pull Request 의 과정을 거친다.
4. Pull Request가 작성되면 충돌 확인 후 merge 한다.
5. 종료된 Pull Request branch는 삭제한다.
```
