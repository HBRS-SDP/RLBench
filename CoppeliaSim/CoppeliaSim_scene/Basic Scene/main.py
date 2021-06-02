
from pyrep import PyRep


#Class to communicate with the robot
class ToyotaHSR():
    def __init__(self):
        '''
        Initiating the robot object

        Input:
            None
        Output:
            None
        '''
        # initializing pyrep object
        self.pyrep = PyRep()
        # path for scene
        scene_path = 'ToyotaHSR_BasicScene.ttt'
        #launching pyrep
        self.pyrep.launch(scene_path, headless=False)


    def _setWheelVelocity(self, first_wheel, second_wheel):
        '''
        Function to set the wheel velocity of robot by calling lua script function

        Input:
            first_wheel: Velocity of first wheel
            second_wheel: Velcoity of second wheel
        '''
        # calling the lua script function to set robot wheel velocity
        _ , _ , _ , _ = self.pyrep.script_call(function_name_at_script_name="setWheelVelocity@script",script_handle_or_type=1 ,ints=() , floats =(first_wheel, second_wheel) , strings=() , bytes = " ")

    def runSimulation(self):
        '''
        Function to start simulation by pyrep

        Input:
            None
        
        Output:
            None
        '''
        # Start the simulation
        self.pyrep.start()
        #setting the first and second wheel velocity
        first_wheel = 1
        second_wheel = 1

        # Track if we are done with our simulation
        done= False
        
        # Global simulation step
        step = 0
        #self._actuateGripper(1)
        # Simulate for one timestep (50ms) until we are done
        
        while not done:
            # Advance the simulation step counter by one
            step+= 1
            # Actually advance the simulation by one step
            self.pyrep.step()            
            # setting the target wheel velocity

            self._setWheelVelocity(1,1)   
            
            #running script for 5 second because each The simulation runs with 20 steps per second by default)
            if step > 20*5:
                done = True
        #setting wheel velocity to zero
        self._setWheelVelocity(0,0)
        #stops the physics simulation
        self.pyrep.stop()
 

    def shutdown(self):
        '''
        Function to shut down pyrep simulation

        input:
            None
        Output:
            None
        '''
        self.pyrep.shutdown()
    
if __name__ == '__main__':
    #creating the robot model
    robot = ToyotaHSR()
    #running the simulation
    robot.runSimulation()
    #shutting down cooppeliasim
    robot.shutdown()