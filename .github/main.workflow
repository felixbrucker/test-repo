workflow "test" {
  on = "push"
  resolves = [
    "Create release on tag",
  ]
}

action "Tag" {
  uses = "actions/bin/filter@9d4ef995a71b0771f438dd7438851858f4a55d0c"
  args = "tag"
}

action "Create release on tag" {
  uses = "felixbrucker/github-actions/publish-release"
  needs = ["Tag"]
}
