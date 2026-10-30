# Repro: `import.meta.env` values with `$` are corrupted in `astro build`

Minimal reproduction for a withastro/astro bug report. When server code reads the
`import.meta.env` object (`const env = import.meta.env`), a private env value that
contains `$$`, `$&`, `$'` or `` $` `` comes out wrong in `astro build`. Reading
`import.meta.env.MY_SECRET` directly is correct.

Set the value in the shell, not in `.env` (dotenv expansion would touch `$` first).

```sh
npm install
MY_SECRET='pa$$ss' npx astro build && cat dist/index.html
```

Expected: both paragraphs contain `pa$$ss`. Actual (astro 7.4.4): `<p id="object">pa$ss</p><p id="direct">pa$$ss</p>`.

`sh repro.sh` runs all five values. `pa$'ss` and ``pa$`ss`` fail the build with `PARSE_ERROR`.
