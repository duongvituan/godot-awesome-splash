## New features in version 0.3
- Splash Container can now contain multiple splash screens.
- Splash Container can work with your node (in v0.2 it can only work with my SplashScreen).
- Added some animations when scrolling the screens.
- You can customize the types of skip, type transition, parameter splash screens in the Splash Container inspector.

Video: update later

## Overview
Collection of splash screens for Godot Engine. Easy to use, fast Installing, multiple resolutions.

You can edit the code, change the logo as you like.

I used [GDAction](https://github.com/duongvituan/godot-action-animation-framework) for animation.

Run on Desktop:

![Desktop](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/desktop_size.gif)

Run on mobile:

![Mobi](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/mobile_size.gif)

Support to easily change logo, title, description by changing param on inspector

You can use **preview_demo** to choose the right splash screen for your project:

![Preview](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/preview_demo.gif)


## Download
you can download all versions [here](https://github.com/duongvituan/godot-awesome-splash/releases)


## Install and use

Watch tutorial video for v.0.2 [here](http://www.youtube.com/watch?v=5ULQduv5GZw) 

Tutorial video for v.0.3: Soon coming


### Installation
Copy the contents of the plugins to the same folder in your project and activate AwesomeSplash and GDAction.

If you need more details, you can watch the video above.


### How to use AwesomeSplash
1. Create folder src/demo_collection/ (if it **doesn't exist** then you can create **src** folder and **demo_collection** folder)

if you want to use the templates in **demo_info_view** then also create and copy to demo_info_view folder  (if it **doesn't exist** then you can create **src** folder and **demo_info_view** folder)

2. Copy demo splash you like to your project in to demo_collection folder.

(Note: If you copy to another folder, just fix the "Load failed due to missing dependencies" error by clicking "Fix Dependencies" and selecting your path.)

3. Create SplashContainer.

4. Drag and drop splash_screen.tscn and your node to SplashContainer.

If you need more details, you can watch the video above.


## Docs
- If you need more information about **docs**, please refer to the [link](docs.md)


## QA:
### How to set main screen is AwesomeSplash.
In Godot engine: Select Project > Project Settings... > Application -> Run -> Main Scene: Select to your Screen Splash screen

### How to hide the default splash screen of Godot engine.
In Godot engine: Select Project > Project Settings... > Application -> Boot Splash -> Image: select (res://addons/awesome_splash/assets/None.png)

### I got an error message "Load failed due to missing dependencies": 
Please put the correct "demo folder" in the path **src/demo_collection/**

(Note: If you copy to another folder, just fix the "Load failed due to missing dependencies" error by clicking "Fix Dependencies" and selecting your path.)

### I got the sprite_language.cpp error message when I installed the plugin:
```core/script_language.cpp:232 - Condition "!global_classes.has(p_class)" is true. Returned: String()```
You may get this error when first time install plugin.
I don't know why - I didn't get this error in the old version, but you can close and reopen the project to fix error :(.

### I don't want to put the code at "src/demo_collection/":
Yes, after successful first run you can change it, godot will automatically fix the import for you. So after successful run you can change the directory of the code.

### I want to change the logo, title, and description in the template.

![splash](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/splash.png)

Yes, you can change background color, animation time, logo, title... via inspector (at - 3 or 5 in above image)


### I want to the user that can skip this splash when they tap on the screen.

![splash](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/container_splash.png)

Yes, you can set it at 6 in above image

### I want to run on mobile (android, ios.. ), what do I need to do?
You don't need to do anything, the splash screen will automatically adjust for you.

### I want to use multiple Splash screens
Yes, in version >= 0.3 you just drag and drop it into SplashContainer.

### I want to use my Node
Yes, in version >= 0.3 you just drag and drop your node into SplashContainer.

## Contribution
Contributions are welcome and are accepted via pull requests.

You can use Tween, AnimationPlayer or GDAction ...etc.. to create SplashScreen.

You can contribute code and submit pull or you can provide ideas and resources by creating an issue. :)


## Support Me

If this plugin is useful to you. Buy me a cup of coffee if you can. 

It motivates me to make more splash temporary and info_view in this plugin.

<a href="https://www.buymeacoffee.com/duongvituan" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>


## License

[MIT License](https://github.com/duongvituan/godot-action-animation-framework/blob/master/LICENSE)

Copyright (c) 2021-present, [Duong Vi Tuan](https://github.com/duongvituan)
