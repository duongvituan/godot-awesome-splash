## This node keep aspect ratio when change the parrent size.
## you need to change the SIZE you want to use in the OutlineFrame Node.
##                                                 
##                                        Your Window                                                        
##                                       ##############                                       
##     AspectNode              #####     #            #                         
##     (ex scale: 3:2)           # #     ##############                                                             
##     ##############          #   #     # AspectNode #                                               
##     #            #        #           #            #                                                         
##     # scale: 3:2 #      #             # scale: 3:2 #                                                       
##     #            #                    #            #                                                                                  
##     #            #                    ##############                                                
##     ##############                    #            #                                                
##                                       ##############                                       
##       #                                                                       
##          #                     Your Window                                                 
##             #     #    ############################                                                       
##                #  #    #      # AspectNode #      #                             
##             # # # #    #      #            #      #                             
##                        #      # scale: 3:2 #      #                          
##                        #      #            #      #                          
##                        ############################                                                    
##                                                                            
##                                                                            
extends Node2D
class_name AspectNode, "res://addons/awesome_splash/assets/icon/aspect_node_icon.png"

var origin_size: Vector2  setget , _get_origin_size
var parrent_size: Vector2 setget _set_parrent_size

onready var outline_frame := $OutlineFrame


func _get_origin_size() -> Vector2:
	return outline_frame.rect_size


func _set_parrent_size(parrent_size: Vector2):
	var splash_origin_size = self.origin_size
	var rect = get_aspect_center_rect(parrent_size, splash_origin_size)
	position = rect.position
	scale = Vector2(rect.size.x / self.origin_size.x, rect.size.y / self.origin_size.y)


func get_aspect_center_rect(parrent_size: Vector2, view_size: Vector2) -> Rect2:
	var weight = min(parrent_size.x, view_size.x * parrent_size.y / view_size.y)
	var height = min(parrent_size.y, view_size.y * parrent_size.x / view_size.x)
	var size = Vector2(weight, height)
	var origin = (parrent_size - size) / 2.0
	return Rect2(origin, size)
