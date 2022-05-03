
## SplashContainer

### Description

This node is root node of splash screen. It can contain multiple splash screens and your custom nodes.

You can change animation types while transition with this node.

![SplashContainer](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/container_splash.png)

1 - Move To Screen: When the splash screens are done, we'll move on to this node.

2 - Transition Type: Types of animations when transition between splash screens.

3 - Transition Time: Time for transition between splash screen.

4 - Custom Node Type: 

    - AUTO: It will wait for a while and automatically move to the next screen.
    
    - CUSTOM: It will not automatically transition with custom node, you need to move the screen with code.
    
ex: code when use custom mode:

```
    func _input(event):
        if event.is_action_pressed("enter"):
            var container = sp.get_current_splash_container()
            container.transition_next_screen()
```
    
5 - Default Time (for custom node): Waiting time when you use AUTO mode

6 - Skip Type:

    - NONE: The user cannot skip splash screens.
    
    - SKIP_ONE_SCREEN_WHEN_CLICKED: When user click on screen will automatically move to next splash screen.
    
    - SKIP_ALL_SCREEN_WHEN_CLICKED: When user click on screen will automatically move to **Move To Screen**.

## AwesomeSplashScreen

![SplashContainer](https://github.com/duongvituan/godot-awesome-splash/blob/master/image_readme/splash.png)


### Description

These are the sample Splash screens of this plugin. As you can see in the image above, they have an icon "S".

You can refer to it in the directory: src/demo_collection (You can download this plugin and run it to check the template you like, no need to copy all sample splashes into your project, just only template you want to use.)

You can change logo or title or description in (3)

1 - Is Skip Appear Transition: if checked, it will ignore transition animation appear screen.

2 - Is Skip Disappear Transition: if checked, it will ignore transition animation disappear screen.

3 - Logo path: link to your image logo, you can change Title and Description in 3

4 - Duration: duration of animation splash screen.

5 - Some properties to change splash screen


## Custom Node

### Description
This can be your splash screen, or some info_view samples (used to warn game type 18+, or symbol when saving game ...).

You can refer to it in the directory: src/demo_info_view


### Delegate in case Custom Node

You can add 2 functions to your custom node:

```python
# This func will auto call from SplashContainer when your node appear
func _custom_splash_did_appear():
    pass

# This func will auto call from SplashContainer when your node disappear
func _custom_splash_did_disappear():
    pass
```

For example, you want to wait sometime when use Custom Node with SplashContainer has **Custom Node Type** == CUSTOM

```python
func _custom_splash_did_appear():
    var time_in_seconds = 2
    yield(get_tree().create_timer(time_in_seconds), "timeout")
    
    var container = sp.get_current_splash_container()
    container.transition_next_screen()
```

### Skip transition animation in Custom Node

You can add 2 variables to script of your custom node. Default values is False.

```python
export(bool) var is_skip_appear_transition = false
export(bool) var is_skip_disappear_transition = false
```
