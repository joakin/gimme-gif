require('./main.css');
var Elm = require('./Main.elm');

var root = document.getElementById('main');

Elm.Main.embed(root, {favs: []});
