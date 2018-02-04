# "Hello World!" in Elm

A fresh take on the otherwise stale "Hello World!" application.

![preview of elm-hello](https://github.com/scottwillmoore/elm-hello/raw/master/preview.gif)

## Features

✔️ Show "Hello World!" in a random langauge every click.

✔️ Animate the transition between different langauges.

✔️ Change the language automatically every 3 seconds.

✔️ Show a visual indicator of the automatic transition.

✔️  Build and upload to Github pages.

❌ Change the background to a random gradient every transition.

## Thoughts

I created this project to learn the basics of Elm, and also to test one of Elm's claimed strengths. Since Elm eliminates runtime errors, it makes implementing new features and maintaining a project much easier. My thoughts on these strengths are still undecided - most likely due to this being my first experience in a purely functional programming langauge.

I am inexperience with Elm, but I found that generating random numbers could be quite tedious. Something that would usually be as simple as `Math.random()`, now requires a separate `Msg` in the update function, which requires two visits through the update function. I now require a `Roll` and a `Show` message in order to generate a random number to choose a random language.

Animations also proved to be quite difficult within Elm. In order to create a simple in-out effect it would require more `Msg`'s and additional state. I was reluctant to add more `Msg`'s and state (and possibly timers), because it seemed wrong and would significantly increase the complexity of the update function. I ended up using Keyed nodes, which is a bit of a hack, and only achieves the in effect. Despite this it does work - without the complexity cost of the alternative approach.

Elm is still in early development, and many of these issues are most likely due to my lack of understanding. If anyone would like to clear up, or ammend any of the points I have raised feel free to raise an issue or create a pull request.

## Setup

Just in case your new to Elm and would like to play around with this project. It should be as simple as [installing elm](https://guide.elm-lang.org/install.html), running `elm-reactor` in the root directory of this project and then navigating to `localhost:8000/src/index.html`.

Building and uploading to Github pages is still a work in progress. The Github pages source has currently been set to the `docs` folder (sucks that you cannot choose the name of the folder), but will most likely moved into a separate `gh-pages` branch at some point. I use `elm-make` to generate `docs/build.js`, and then all other assets are currently manually synced between the `src` and `docs` directory. I *might* write a script at some point in the future to streamline this process.
