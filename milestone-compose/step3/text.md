Read the board twice, and look at where the answer came from:

`curl -s localhost:9000/api/bounties | grep -o '"source":"[a-z]*"'`{{exec}}

`curl -s localhost:9000/api/bounties | grep -o '"source":"[a-z]*"'`{{exec}}

The first read comes from the `database` (unless you've already read it in the last 30 seconds), and the next from the `cache`.

Now add **Nico Robin**, with a bounty of **930000000**, by sending JSON to the same address with `POST`. Then read the board again:

`curl -s localhost:9000/api/bounties`{{exec}}

Press **Check** when Nico Robin is on the board.

<br>

<details><summary>Tip</summary>

`curl` sends with `-X POST`, the header `Content-Type: application/json` goes after `-H`, and the JSON after `-d`: `{"name": "Nico Robin", "bounty": 930000000}`. The bounty is a number, so it has no quotes.

</details>

<details><summary>Solution</summary>

```plain
curl -s -X POST -H 'Content-Type: application/json' -d '{"name": "Nico Robin", "bounty": 930000000}' localhost:9000/api/bounties
```{{exec}}

</details>
