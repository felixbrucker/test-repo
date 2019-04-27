workflow "test" {
  on = "push"
  resolves = [
    "Post to Discord",
  ]
}

action "Tag" {
  uses = "actions/bin/filter@9d4ef995a71b0771f438dd7438851858f4a55d0c"
  args = "tag"
}

action "Create release on tag" {
  uses = "felixbrucker/github-actions/publish-release@master"
  needs = ["Tag"]
  secrets = ["GITHUB_TOKEN"]
  args = ["--name", "BHD-Burst-Proxy"]
}

action "Post to Discord" {
  uses = "felixbrucker/github-actions/post-release-in-discord@master"
  needs = ["Create release on tag"]
  secrets = ["WEBHOOK_ID", "WEBHOOK_TOKEN"]
  args = ["--authorName", "Felix Brucker", "--authorUrl", "https://github.com/felixbrucker", "--authorIcon", "https://avatars1.githubusercontent.com/u/5189997?s=40&v=4"]
}