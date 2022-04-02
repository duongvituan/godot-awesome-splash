## New features in version 0.3
-  Splash Container can now contain multiple splash screens.
- Splash Container can work with your node (in v0.2 it can only work with my SplashScreen).
- Added some animations when scrolling the screens.
- You can customize the types of skip splash screens in the Splash Container inspector.

Video: update late

## Overview
Collection of splash screens for Godot Engine. Easy to use, fast Installing, multiple resolutions.

You can edit the code, change the logo as you like.

I used [GDAction](https://github.com/duongvituan/godot-action-animation-framework) for animation.

Run on Desktop:

![Desktop](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/desktop_size.gif)

Run on mobile:

![Mobi](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/mobile_size.gif)

Support to easily change logo, title, description by changing constant variables

![Change](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/change_info.gif)

You can use **preview_demo** to choose the right splash screen for your project:

![Preview](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/preview_demo.gif)


## Install and use

Watch tutorial video [here](http://www.youtube.com/watch?v=5ULQduv5GZw)


### Installation
Copy the contents of the plugins to the same folder in your project and activate AwesomeSplash and GDAction.

If you need more details, you can watch the video above.


### How to use AwesomeSplash
1. Create folder src/demo_collection/ (if it **doesn't exist** then you can create **src** folder and **demo_collection** folder)
2. Copy demo splash you like to your project in to demo_collection folder.
(Note: If you copy to another folder, just fix the "Load failed due to missing dependencies" error by clicking "Fix Dependencies" and selecting your path.)
3. Create SplashContainer.
4. Drag and drop splash_screen.tscn to SplashContainer.

If you need more details, you can watch the video above.


## QA:
### How to set main screen is AwesomeSplash.
In Godot engine: Select Project > Project Settings... > Application -> Run -> Main Scene: Select to your Screen Splash screen

### How to hide the default splash screen of Godot engine.
In Godot engine: Select Project > Project Settings... > Application -> Boot Splash -> Image: select (res://addons/awesome_splash/assets/None.png)

### I got an error message "Load failed due to missing dependencies": 
Please put the correct "demo folder" in the path **src/demo_collection/**

(Note: If you copy to another folder, just fix the "Load failed due to missing dependencies" error by clicking "Fix Dependencies" and selecting your path.)

### I don't want to put the code at "src/demo_collection/":
Yes, after successful first run you can change it, godot will automatically fix the import for you. So after successful run you can change the directory of the code.

### I want to change the logo, title, and description in the template.
Yes, you can change background color, animation time, logo, title... via constant variables in the splash_screen.gb file.

```
const LOGO_PATH := "res://src/demo_collection/demo7/src/logo.png"
const TITLE := "GODOT"
const DESCRIPTION := "Game engine"
```

You should use a logo that is only white. I can script to manually adjust all logos to 1 color but it doesn't seem like a good idea as it can ruin your design. I'm still looking for ideas for this, maybe it will be added in the future.


### I want to the user that can skip this splash when they tap on the screen.

This feature already exists, in the splash container, you change the function _splash_screen_can_be_skipped_when_clicked_screen to return true (default is false).
```
func _splash_screen_can_be_skipped_when_clicked_screen() -> bool:
    return true
```

### I want to run on mobile (android, ios.. ), what do I need to do?
You don't need to do anything, the splash screen will automatically adjust for you.


## Contribution
Contributions are welcome and are accepted via pull requests.

You can use Tween, AnimationPlayer or GDAction ...etc.. to create SplashScreen.

You can contribute code and submit pull or you can provide ideas and resources by creating an issue. :)


## License

[MIT License](https://github.com/duongvituan/godot-action-animation-framework/blob/master/LICENSE)

Copyright (c) 2021-present, [Duong Vi Tuan](https://github.com/duongvituan)
