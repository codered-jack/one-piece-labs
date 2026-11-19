#!/bin/bash
# Writes the .env file the last step keeps out of the image. It's created here
# instead of shipped as an asset because the repo's .gitignore excludes every
# .env* file. The value is deliberately fake: lab machines never get real secrets.
mkdir -p /root/wanted
printf 'API_KEY=not-a-real-key\n' > /root/wanted/.env
