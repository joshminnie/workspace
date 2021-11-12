# Pull Requests

## Opening a pull request

Before creating a pull request, create a GitHub issue. All pull requests must point to an existing issue.

## Getting your pull request merged

Here are some reasons why a pull request may not be merged:

1. It doesn't have an associated issue.
2. It hasn’t been reviewed.
3. It doesn’t include specs for new functionality.
4. It doesn’t include documentation for new functionality.
5. It changes behavior without changing the relevant documentation, comments, or specs.
6. It changes behavior of an existing public API, breaking backward compatibility.
7. It breaks the tests on a supported platform.
8. It doesn’t merge cleanly (requiring Git rebasing and conflict resolution).

If you would like to help in this process, you can start by evaluating open pull requests against the criteria above. For example, if a pull request does not include specs for new functionality, you can add a comment like: "If you would like this feature to be added to Workspace, please add specs to ensure that it does not break in the future." This will help move a pull request closer to being merged.

---

_**IMPORTANT**: Include this emoji in the top of your ticket to signal to us that you read this file:_ 🉑
