# gimme-gif

A small webapp to get a random gif related to a tag.

Visit [chimeces.com/gimme-gif](https://chimeces.com/gimme-gif) for the live
version.

# Dev

After a `npm install && elm package install -y` just do:

```
npm start
```

And visit `http://localhost:3006`

## Tests

Run `npm run test:install` first time you want to run the tests.

Afterwards for a single run do `npm test`.

For running the tests watching for file changes run `npm run test:watch`

# Prod

```
npm run build
```

Assets are built to the `dist` folder.
