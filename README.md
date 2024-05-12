# Concentration

| Table of Contents |
| ----------------- |
| [About](#about) |
| [Design](#design) | 
| [Ports](#ports) |
| [Goals](#goals) |

## About

This project is a re-creation of the card game [concentration](https://en.wikipedia.org/wiki/Concentration_(card_game)). The goal of the game is to match up each card with another that has the same rank. This is done by choosing two face-down cards and flipping them to see if they match, staying face-up if they do. This must be done in as few turns as possible.

## Design

The initial design is quite simplistic, only using a turn counter, timer, and start button, along with 54 cards:
![](Images/Design.jpg)

The current design is similar, with the main difference being the addition of two more cards (2 jokers) and the timer using only seconds:
![](Images/Elm%20port.png)

The project uses google's [material design](https://m3.material.io/), more specifically [material web components](https://github.com/material-components/material-components-web), which works for most web frameworks.

## Ports

This web application is currently split into two web framework ports: [Elm](https://elm-lang.org/) and [Vue](https://vuejs.org/), discussed below.

### Elm

*Note: This project was initially started using Elm, alongside a severe lack of experience in building web apps and functional programming, so the following opinions may be slightly biased.*

Before this project, the only experience in functional programming was a few Haskell tutorials, so while I knew a little bit of what to expect I still found myself quite lost. The official tutorials on Elm were very boring and had little explanation as to how things worked. While the aspects of the language were (mostly) understandable, I couldn't imagine building anything with it, nor even comprehend how to use it for building a web app. Luckily, I had eventually found this [comprehensive and interactive tutorial by Pawan Poudel](https://elmprogramming.com/). Using this tutorial I was able to actually learn the language as well as the framework (which the official tutorial skims over).

Once I had begun creating the web app, I found that Elm was rather concise, allowing me to see how an app works using its model, view and update functions. I also enjoyed the functional aspects, such as the convenient type system, and concise list functions.

On the otherhand, I'm not entirely sure how to feel about the lack of parentheses in function calls because, while I love it, I feel function chaining might not be enough to make sense of what a function is doing. Additionally, I found a severe lack of documentation and variety of Elm packages, limiting what I was able to achieve in a reasonable amount of time. For example, the [package](https://package.elm-lang.org/packages/aforemny/material-components-web-elm/latest/) I used to import the material design components did little to explain how to set the number of columns in an image list, as well as nothing to explain why the device-specific spans on layout grids do not function.

All in all, I enjoyed using Elm, but learning it was more difficult than it should have been, and I would greatly appreciate more documentation and a larger package ecosystem.

### Vue

Unlike Elm, [Vue's official guide](https://vuejs.org/guide/introduction.html) is much more comprehensive. In fact, I found it faced the exact opposite problem of Elm's documentation, it was too comprehensive, using terminology and concepts unfamiliar to one inexperienced in building web apps. 

Some things I loved about Vue was the large ecosystem, the power offered by the use of template directives, and the support for splitting applications into several components.

Overall, I liked the power offered by Vue, but I prefer the functional syntax and simplicity of Elm.

## Goals