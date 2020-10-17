# The renderer accepts a game object and creates a visual representation of that.

# Dev Paths
# Add react to the framework and render the game object as json and send that to an indpendent frontend
# Create a CLI renderer that you can use for the local version of this
# Make a crazy basic ruby server side render html css string that gets pumped to the output.  This is so weird and basic.  We'll start this way for fun.

# Also, one of the real issues here is that the game engign is sending user messages and collecting data from the terminal. We want a more robust way of io.

class Renderer
  attr_accessor :game
  def initialize(game)
    @game = game
  end
end

# Push out an html/css page
class HTMLRenderer < Renderer
  def render
    output = ""
    output += "<h1>Pandemic</h1>"
    output += "<p>#{game}</p>"
    return output
  end
end

# Output a json version of the game?
class JSONRenderer < Renderer
  def render
    "#{game}"
  end
end



# Should the game be passed to the renderer or the renderer to be passed to the game?
# THe game object right now hides all of it's data but exposes a to_s method. It also is printing shit on it's own. The printing should be somewhere else no?
