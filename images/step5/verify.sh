#!/bin/bash
# Passes when the container scribble and the image python:3.12-alpine are both gone.
! docker container inspect scribble >/dev/null 2>&1 || exit 1
! docker image inspect python:3.12-alpine >/dev/null 2>&1
