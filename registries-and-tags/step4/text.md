A tag can move, as `latest` just did. A digest can't: it's a fingerprint of the image's contents. List each tag with its digest:

`docker image ls --digests localhost:5000/wanted`{{exec}}

Save version 1.0's name pinned by its digest to `~/pinned.txt`. It looks like this, with your own digest:

```plain
localhost:5000/wanted@sha256:efea1df236cb81051aa63fe868caaa6426f9714ce6fb8c44e3090847e1db1fcf
```

Then run it:

`docker run $(cat ~/pinned.txt)`{{exec}}

It prints the 1,000-berry poster, whatever happens to the tags. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

Put `@` and the digest where the tag would go. The digest of `1.0` is also on the last line of its `docker push` output.

</details>

<details><summary>Solution</summary>

Pushing `1.0` again uploads nothing new, but prints its digest once more. `awk` turns that line into the pinned name:

```plain
docker push localhost:5000/wanted:1.0 | awk '/digest:/ { print "localhost:5000/wanted@" $3 }' > ~/pinned.txt
cat ~/pinned.txt
```{{exec}}

</details>
