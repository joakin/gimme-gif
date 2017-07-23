import "./main.css";
import * as Elm from "./Main.elm";

const root = document.getElementById("main");
Elm.Main.embed(root, { favs: [] });
