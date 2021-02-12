def main(ctx):
  if ctx.build.event == "tag":
    name = "release"
  elif ctx.build.branch == "master":
    name = "master"
  else:
    return

  return {
    "kind": "pipeline",
    "name": name,
    "steps": [
      {
        "name":  "prepare data",
        "image": "alpine",
        "commands": [
          "apk update && apk add bash curl",
          "FORCE_DOWNLOAD=y ./build-tmp-XXX"
        ]
      },
      step_for(ctx, "core"),
      step_for(ctx, "ocrd_olena"),
      step_for(ctx, "ocrd_tesserocr"),
    ]
  }

def step_for(ctx, sub_image):
  return {
    "name": "build %s" % sub_image,
    "image": "plugins/docker",
    "settings": {
      "build_args": [
        "DRONE_COMMIT=%s" % ctx.build.commit,
      ],
      "tags": [
        ctx.build.commit,
      ],
      "username": { "from_secret": "docker_username" },
      "password": { "from_secret": "docker_password" },
      "repo": "mikegerber/my_ocrd_workflow-%s" % sub_image,
      "dockerfile": "Dockerfile-%s" % sub_image,
    }
  }
