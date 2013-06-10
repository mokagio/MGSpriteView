MGSpriteView
============

A UIView subclass to play animation using a sprite sheet and compatible with the Cocos2d .plist syntax.

MGSpriteView wouldn't be possible without [MCSpriteLayer](http://mysterycoconut.com/blog/2011/01/cag1/) and the research and development work that produced it. See [Mystery Coconut Games blog](http://mysterycoconut.com/blog/) for more info.

Don't forget to add the CoreAnimation framwork (QuartzCore.framework) to your project!

###Roadmap

####v0.0.3
* `MGSpriteAnimation`. Since `MGSpriteView` is not a view and it's meaningful only for animations it needs some refactoring

####v0.0.4
* (new) `MGSpriteView`. A view that we can init with a spritesheet and a sprite name.

###TODO List
* Test Performance
* Cover possible fails
* Allow pause and resume for the animation
* Allow manual control for the animation
* Fully supporting of the Cocos2d .plist protocol, using two dictionary files, hd and sd.

###Links and Readings
* [Read a Cocos2d plist output](http://gamedev.stackexchange.com/questions/18758/in-cocos2ds-plist-output-what-are-offset-colorsourcerect-and-these-other)
