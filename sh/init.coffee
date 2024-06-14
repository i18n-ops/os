#!/usr/bin/env coffee

> path > join dirname
  @3-/walk > walkRel
  fs > symlinkSync existsSync rmSync mkdirSync

ROOT = dirname import.meta.dirname


rsync = (base)=>
  dir = join ROOT, base

  link = (fp, to) =>
    fp = join(dir,fp)
    todir = dirname(to)
    if not existsSync todir
      mkdirSync todir, recursive: true
    symlinkSync(
      fp
      to
    )
    return

  for await fp from walkRel(
    dir
    (fp)=>
      if fp == '.git'
        return 1
      for i from [
        '.config/git'
        '.ssh'
        '.codeium'
      ]
        if fp.endsWith('/'+i)
          console.log base, fp
          to = '/'+fp
          rmSync(to, { recursive: true, force: true })
          link(
            fp
            to
          )
          return 1
      return 0
  )
    console.log base, fp
    to = '/'+fp
    rmSync(to, { force: true })
    link(
      fp
      to
    )
  return

for base from ['pub','secret']
  await rsync base

process.exit()
