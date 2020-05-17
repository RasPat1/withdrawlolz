# Readme.md

## Pandemic
Played Pandemic for the first time. So fun. It seems that we can make an attempt at having a machine choose optimal paths. After all, the random card drawing becomes far less random after a few epidemics. So we can try to do some cmputer attempts at playing the game. At each turn there are a fixed number of moves and then a certain number of possibilities and etc etc. So it's basically like chess right there are a limited number of possibliites and we're goign to try to gollow a path with the highest outcome of success. We can do an AI attempt at this. We can do Graph serach with backttrackign and pruning. We can do a probabilisstic and time bound model to find paths leading to good "evaluations". etc etc. So anyways as you can tell alllooooot of fun goign on here. Let's see what we can do.

# V1 -- Rules engine and Representation
Well let's start with the simplest verions of this.
* Generate a simple map with one player and make sure we have a basic rules engine working.
* Represent each city as a node with bidirectional edges.
* Define motion of players between these cities.
* Have a players which can move along these nodes.
* Program in the 8 basic actions that they can do.

# Future versions
* More than one player
* Players with special ability
* Graphical representation
* Creating an evaluation system
* Having system calculate and compare evaluation at multiple paths
* Do Backgracking, pruning, probability calculations etc
* Create simple AI decision engine based on evaluation
* Create a prioiri AI using unsupervised learning to determine it's own path to victory
* Create tools for viewing probabilities, forcing bad outcomes, etc.
* Lol this is like a 3 week project