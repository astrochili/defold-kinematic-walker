# Defold Kinematic Walker

![](https://user-images.githubusercontent.com/4752473/175769046-bbf9f71c-c970-4921-a27f-d56361ce0e53.png)

## Overview

This is a tweakable kinematic character controller suitable for 3D games made with [Defold](https://defold.com). When you wouldn't like to use a dynamic body and prefer to have more control over the movement.

Although not all the collision cases are handled perfect at the moment, you can [avoid problems](#troubleshooting) by providing valid and smooth collision geometry of your level. The geometry in the demo is not smooth exclusively for stress testing purposes.

Ready to use with [Operator](https://github.com/astrochili/defold-operator/) or you own camera controller.

[Play HTML5 demo](https://astronachos.com/defold/kinematic-walker).

[Discuss on the forum](https://forum.defold.com/t/kinematic-walker-character-movement-controller-for-3d-games/71160/).

## Features

- Collision resolving with level geometry.
- Walking and running.
- Jumping and crouching.
- Climbing slopes and curbs.
- Smooth acceleration and deceleration.
- Internal control with key bindings.
- External manual control with messages.
- Spectator mode.

## Install

Add link to the zip-archive of the latest version of [defold-kinematic-walker](https://github.com/astrochili/defold-kinematic-walker/releases) to your Defold project as [dependency](http://www.defold.com/manuals/libraries/).

## Quick Start

1. Add the `collision_standing` collision object with the capsule shape to your character's gameobject. The position anchor must be on the floor. Set type to `Kinematic`, set group to `walker` and switch locked rotation to `true`.

2. Add `walker.script` to your character's gameobject and configure its script properties in the editor.

### Crouching

To allow crouching add the `collision_crouching` collision object with the capsule shape with the same collision properties as the `collision_standing` but with a lower height.

### Camera

To follow your camera gameobject rotation:

```lua
  msg.post(walker_url, hash 'follow_camera', { camera = camera_url })
```

To automatically move the camera up and down when standing and crouching add an empty gameobject `eyes` in the walker gameobject and use it to attach your camera.

### Operator

To use [Operator](https://github.com/astrochili/defold-operator/) as the camera controller:

```lua
  msg.post(operator_url, hash 'follow_point', { object = eyes_url })
  msg.post(walker_url, hash 'follow_camera', { camera = operator_url })
```

### Controls

To customize controls just change [`internal_control`](#internal_control-1) key bindings or post [`manual_control`](#manual_control) messages to control the movement manually.

## Walker Properties

### observer

The `url`  where to send the walker events. Usually it's your character script.

### spectator_mode

Activates the spectator mode during initialization. In this mode you can fly without the gravity applying.

### spectator_clipping

Resolves the collisions in the spectator mode. If you disable this option, you can fly through walls.

### internal_control

Enables internal control with default key bindings during initialization.

### normal_speed

Normal speed of walking. Units per second.

### shift_speed

Alternative speed of walking is activated with the [`input.shift`](#internal_control-1). Units per second.

If you want to run by default and walk only with the shift input set this property less than [`normal_speed`](#normal_speed).

### acceleration

How much units of velocity should be changed per second to get a greather velocity. Use your [`normal_speed`](#normal_speed) and [`shift_speed`](#shift_speed) as references.

- `10` - if the `normal_speed` is `5`, then the time required to accelerate from the zero velocity to the walking velocity will be `0.5` seconds.
- `0` - _don't use if you want to move the walker._

### deceleration

How much units of velocity should be changed per second to get a lower velocity. Use your `normal_speed` and `shift_speed` as references.

- `20` - if the `normal_speed` is `5`, then the time required to decelerate from the walking velocity to the zero velocity will be `0.25` seconds.
- `0` - _don't use otherwise you will never stop the walker._

### is_crouching_allowed

Allows to crouch. Be sure that the `collision_crouching` is set.

Use it to temporary disable crouchoing in runtime, for example.

### stair_height

Maximum height of the stair to climb.

- `0` - ignore any stairs.
- `0.3` - automatically moves up on surfaces no higher than `0.3`.

### stair_angle

Maximum deviation angle in degrees of the stair surface to climb.

Allowed values are from `0` to `30` degrees, because after `30` it's too unstable.

- `0` - only horizontal stairs will be handled.
- `15` - stairs with angle from `-15` and up to `15` degrees will be handled.

### jump_power

Speed of the jump impulse in units per second. Applies immediately to `y` of the current velocity.

- `10` - jump immediately up with `10` units per second speed.

### anti_bunny_time

Seconds required to stay on the ground before the next jump.

- `0.2` - a little delay before the next jump.

### air_control

How much is possible to change the moving direction in the air.

- `0` - where it jumped, that's where it fall.
- `0.3` - a little control over the direction of the fall.
- `1` - a full control of horizontal moving in the air.

### climbing_angle

The angle of slopes which are available for climbing.

Allowed value is from `0` up to `90` degrees.

- `0` - any slope will be as a wall.
- `46` - allow to climb slopes up to `46` degrees.

Use a value that will never be used in the level geometry to avoid persistence mistakes.

### slope_speed_factor

How much the angle of the slope affects the walker speed.

The calculation comes from the fact that a 45 degree slope is -50% speed on the uphill and +50% speed on the downhill. Then this effect is multiplied by this factor.

- `0` - the speed always is the same.
- `0.5` - half of the effect applies.

### gravity

The force of gravity when there is no ground under the walker. Units per second. 

- `vmath.vector3(0, -8, 0)` - a falling gravity with 8 units per second speed.

The `x` or `z` gravity values also should work but has not been tested enough.

### gravity_acceleration

How much units of velocity should be changed per second to reach the [`gravity`](#gravity) velocity.

- `3` - if the `gravity.y` is `-6`, then the time required to accelerate from the zero velocity to the gravity velocity is `2` seconds.

### sensor_length

The sensor length to check the ground, ceiling and slopes. Minimum value is `0.05` because of the Bullet physics [collision margin](https://forum.defold.com/t/using-a-dae-mesh-for-collision/69434/3).

### collision_standing

The `url` of the collision object with a standing capsule shape.

### collision_crouching

The `url` of the collision object with a crouching capsule shape. 

Is optional if you don't plan to allow crouch.

### walker_collision_group

The collision group you set in the [`collision_standing`](#collision-standing) and [`collision_crouching`](#collision-crouching) collision object properties.

### world_collision_group

The collision group you use in the level geometry.

### eyes_position_url

The `url` of a gameobject for the camera attachment. Its position will be animated when crouching and standing.

Is optional if you don't plan to switch the camera position.

### eyes_switch_duration

Duration of the `eyes` gameobject position animation when crouching and standing.

## Incoming Messages

### debug

Enable or disable the debug mode. It draws some debug lines to understand what happens.

```lua
msg.post(walker_url, hash 'debug', { is_enabled = true } )
```

### spectator_mode

Enable or disable the [spectator mode](#spectator_mode).

```lua
msg.post(walker_url, hash 'spectator_mode', { is_enabled = true } )
```

### follow_camera

Follow the camera object rotation to apply it on the walker rotation.

```lua
msg.post(walker_url, hash 'follow_camera', { camera = camera_url })
```

### unfollow_camera

Stop to follow the camera object rotation.

```lua
msg.post(walker_url, hash 'unfollow_camera')
```

### internal_control

Configure internal controls. Set action identifiers or disable the internal control at all.

- `is_enabled` - enanbles or disables internal control.
- `bindings.forward` - forward moving action id.
- `bindings.backward` - backward moving action id.
- `bindings.left` - left strafing action id.
- `bindings.right` - right strafing action id.
- `bindings.jump` - jumping action id.
- `bindings.crouch` - crouching action id.
- `bindings.shift` - alternative walking speed action id.

```lua
local bindings = {
    forward = hash 'key_w',
    backward = hash 'key_s',
    left = hash 'key_a',
    right = hash 'key_d',
    jump = hash 'key_space',
    crouch = hash 'key_c',
    shift = hash 'key_lshift'
}

local message = {
    is_enabled = true,
    bindings = bindings
}

msg.post(walker_url, hash 'internal_control', message)
```

### manual_control

Manually control movement of the walker. The structure is similar with [bindings](#internal_control-1) but all the values must be `bool` or `nil`.

```lua
local input = {
    forward = true,
    left = true,
    crouch = true,
}

msg.post(walker_url, hash 'manual_control', input)
```

### pause

Enables or disables the update and collision resolving functions.

```lua
msg.post(walker_url, hash 'pause', { is_paused = true })
```

Useful in HTML5 builds when the web browser tab loses the focus, check the [example](example/player.script).

## Outgoing Messages

### walker_moving

- `direction` - a normalized direction of the movement.
- `speed` - speed in the units per second.
- `is_grounded` - standing on the ground or not.

Sends to the [`observer`](#observer) when speed of the walker is greather than zero.

### walker_standing

Sends to the [`observer`](#observer) when the walker has stood up.

### walker_crouching

Sends to the [`observer`](#observer) when the walker has crouched down.

### walker_jumping

Sends to the [`observer`](#observer) when the walker has jumped.

### walker_falling

- `height` - the height of the fall.

Sends to the [`observer`](#observer) when the walker has fell down on the ground.

The counter starts from the highest visited point in the air.

### walker_trigger_enter

Forwards the [`trigger_response`](https://defold.com/ref/beta/physics/#trigger_response) to the [`observer`](#observer) when the walker has entered a trigger.

### walker_trigger_exit

Forwards the [`trigger_response`](https://defold.com/ref/beta/physics/#trigger_response) to the [`observer`](#observer) when the walker has left a trigger.

### object_post_movement

- `position` - the actual position of the walker.
- `correction` - the last position correction.

Sends to the [`observer`](#observer) and the following [`camera`](#follow_camera) post movement corrections after collision resolving in the `on_message` function.

> Used by [Operator](https://github.com/astrochili/defold-operator/) to update the camera position without lags.

### ground_normal

- `normal` - the ground normal or nil.

Sends to the following [`camera`](#follow_camera) the current ground normal.

> Used by [Operator](https://github.com/astrochili/defold-operator/) to align the camera to the ground slope.

## Troubleshooting

### Stairs

The current handling of stairs is more suitable for climbing on curbs. Don't use the stairs as is, better to use a slope collision object.

### Internal geometry

To avoid stucking along the objects, try to remove any internal unused collision geometry.

Using of planes as collision objects along the wall is preferable to boxes to avoid collisions with the joints of these boxes. Keep the collision geometry as simple as possible.

### Fall into a gorge

Place a horizontal hidden collision object at the bottom of the gorge so that there is something to stand on, otherwise the walker may get stuck.