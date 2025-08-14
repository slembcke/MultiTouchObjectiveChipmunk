# This Project has Moved!

You can find the new project page on the [Chipmunk2D Website](https://chipmunk-physics.net/git/MultiTouchObjectiveChipmunk.html).

To migrate an existing checkout, you can use the following command, or make a new checkout of the project from the new location.

```
git remote set-url origin https://chipmunk-physics.net/git/MultiTouchObjectiveChipmunk
git fetch origin master
git reset origin/master
```

You may additionally need to run `git checkout .` to cleanup the deleted files. *This will also discard your local changes if you have made any.*

MultiTouchObjectiveChipmunk
=

This is a very simple example showing how to easily implement multi-touch physics with Cocos2D 2.1 and Objective-Chipmunk.

Chipmunk (the C-API) is free and open source software. Chipmunk Pro (including the Objective-C binding and optimized solver) is what we've built on top of Chipmunk. Chipmunk Pro can help you save a lot of time as it plugs into the usual Objective C memory model and familiar APIs. It even works seamlessly with ARC. You can learn more here: http://chipmunk-physics.net/chipmunkPro.php

This example features the Objective-Chipmunk class ChipmunkMultiGrab, and it includes the trial version of Chipmunk Pro.
