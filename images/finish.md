# Lab complete

You just:

- pulled an image by **tag**, without running it
- counted the read-only **layers** that make up `python:3.12-alpine`
- wrote a file in one container, and saw that a new container couldn't find it
- found that file in the container's **writable layer** with `docker diff`
- removed a container, then the image

Next up is *Build your own image*, where you'll write the recipe card yourself.
