# Contributing 

Contributions can take any form. Bugs. Ideas. Feature requests. While code contributions are usually the most common, they are far from the most ideal. 

Before you write code, stop. 

Ask **why**. 

Why does this code need to exist? Is the idea actually sound? If you can't explain the reason, you don't understand it yet. Once you believe it, try to presuade a peer. If you can't, the idea isn't ready. 

Then ask **what**. 

What is the shape of this change? 
Where does it live? 
What does it touch? 
What should it NOT touch? 

This is architecture, even if it's small. 
Draw it. Maybe on a whiteboard. 
This is a good time to pull in your prospective reviewer.

Only after the why and the what are solid should you move on to **how** (NB: things are rarely this linear, something you may need to work on the how as you work on the what - but it is almost always the case that you need to re-work the how at the end). 

The how is mostly solitary work. Unless it's a very big change this part is all you. You will need to squash the nit-picker within you that wants to brush up every single line. Focus on the main things: 

* Robustness
* Security/Privacy
* Documentation

Flag doubts. Don't be silent just because you don't have time to fix it. 

When you're ready to send a pr, tidy it up with a good commit messages. Here is a baseline

```
Summarize changes in 50 characters 

More details. Word wrap to 80 chars. 
1. Explain the problem
2. Focus on the "why" 
3. Briefly explain the "what" 
4. You pr explains the "how" - you don't need to

Add unfinished items to a bug, eg: 
Bugs: #123
```

## Practical matters

First, setup _this_ repository. Follow [these](https://www.kubernetes.dev/docs/guide/github-workflow/) steps. Be sure to replace your `user` and `project` (heartwood) name in the commands you run. 

Then setup _the remaining_ repositories by following the guidelines in [README.md](README.md). This step involves cloning all the conservation coalition projects into the `./repos` directory. All your changes belong in one of these repos. 




