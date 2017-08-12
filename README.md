# Visualization in Miso

## Development

For faster edit-compile-run cycle it is recommended to to use `GHCJSi` as follows.

First, enter the Nix configured shell environment:

```
nix-shell
```

Then, enter the GHCJSi shell:


```
cabal configure --ghcjs
cabal repl
```

GHCJSi starts up a webserver. You should connect to it from the web browser now at http://localhost:6400/


From the GHCJSi shell, everytime `Main.js` changes, recompile and send the new code to the browser:

```
> :r
> clear > main
```

The Html document in the webbrowser will update automatically with the new code!

## Production

This application be built for production and run as follows:

```
nix-build
warp -d result/bin/app.jsexe/
```
