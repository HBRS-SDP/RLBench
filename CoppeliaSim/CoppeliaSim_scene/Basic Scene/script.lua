function sysCall_init()
    
    -- Initialise variables for object handle
    
    -- For wheels 
    h_wheels    = {-1, -1} -- < left, right>
    
    -- For robot arm 
    h_arm = {-1} -- Arm flex joint 
    h_gripper = {-1, -1} -- hand distal joint <left, right>
    
    -- For robot head 
    h_head ={-1} 
    
    -- Get individual object handles 
    
    -- Wheel joints
    h_wheels[1] = sim.getObjectHandle("base_l_drive_wheel_joint") -- Object handle for left wheel joint
    h_wheels[2] = sim.getObjectHandle("base_r_drive_wheel_joint") -- object handle for right wheel joint
    
    -- Robot arm 
    h_arm[1] = sim.getObjectHandle("arm_flex_joint") -- Object handle for arm joint
    h_gripper[1]= sim.getObjectHandle("hand_l_distal_joint") -- Object handle for hand distal joint left
    h_gripper[2]= sim.getObjectHandle("hand_r_distal_joint") -- Object handle for hand distal joint right
    
    -- Robot head 
    h_head[1] = sim.getObjectHandle("head_tilt_joint") -- Object handle for robot head
    
    -- Set individual joint velocities

    
    -- Robot arm
    sim.setJointTargetVelocity(h_arm[1], 0.) -- Set velocity for robot arm joint (For stability)
    sim.setJointTargetVelocity(h_gripper[1], 0.) -- Set velocity for robot hand distal joint left (For locking motor)
    sim.setJointTargetVelocity(h_gripper[1], 0.) -- Set velocity for robot hand distal joint right (For locking motor)
    
    -- Robot head 
    sim.setJointTargetVelocity(h_head[1], 0.) -- Set velocity for robot head joint (For locking motor)

    -- At each simulation step, we will set the velocities and the target configuration of the robot arm
    -- Here we define the global variables that hold our target values
    first_wheel = 0
    second_wheel = 0

end


function _applyWheelVelocity(target_first_wheel, target_second_wheel)
    -- function to set the wheel velocity of robot
    sim.setJointTargetVelocity(h_wheels[1], target_first_wheel) -- Set velocity for left wheel joint (for motion)
    sim.setJointTargetVelocity(h_wheels[2], target_second_wheel) -- Set velocity for right wheel joint (for motion)
end

-- Robot Movement: function which is called by python script. This function by default take 4 arguments which
--                 are ints, floats, strings, bytes
function setWheelVelocity(ints, floats, strings, bytes)
    -- Setting the first and second wheel velocity obtained from python script.
    
    first_wheel = floats[1]
    second_wheel = floats[2]
    return {},{},{},""
end
