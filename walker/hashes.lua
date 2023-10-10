--[[
  hashes.lua
  github.com/astrochili/defold-kinematic-walker

  Copyright (c) 2023 Roman Silin
  MIT license. See LICENSE for details.
--]]

local hashes = {
  acquire_input_focus = hash 'acquire_input_focus',
  collision_mask = hash 'collision_mask',
  contact_point = hash 'contact_point',
  debug = hash 'debug',
  default = hash 'default',
  did_init = hash 'did_init',
  disable = hash 'disable',
  draw_line = hash 'draw_line',
  enable = hash 'enable',
  euler_y = hash 'euler.y',
  far_z = hash 'far_z',
  follow_camera_rotation = hash 'follow_camera_rotation',
  ground_normal = hash 'ground_normal',
  internal_control = hash 'internal_control',
  manual_control = hash 'manual_control',
  object_post_movement = hash 'object_post_movement',
  pause = hash 'pause',
  position = hash 'position',
  post_update = hash 'post_update',
  ray_cast_missed = hash 'ray_cast_missed',
  ray_cast_response = hash 'ray_cast_response',
  spectator_mode = hash 'spectator_mode',
  teleport = hash 'teleport',
  trigger = hash 'trigger',
  unfollow_camera_rotation = hash 'unfollow_camera_rotation',
  walker_crouching = hash 'walker_crouching',
  walker_falling = hash 'walker_falling',
  walker_here = hash 'walker_here',
  walker_jumping = hash 'walker_jumping',
  walker_moving = hash 'walker_moving',
  walker_standing = hash 'walker_standing',
  walker_trigger_enter = hash 'walker_trigger_enter',
  walker_trigger_exit = hash 'walker_trigger_exit',
}

return hashes