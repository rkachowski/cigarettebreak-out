define ["cs!app/player", "cs!app/ball", "cs!app/constants", "cs!app/brick"], (Player, Ball, Constants, Brick) ->

  class Editor
      @tiles: []

      @activate:(@game, @brickback) =>
          $("#game").mousedown @onClick
          $("#game").mousemove @onMove
          $("#game").mouseup @onUp

          $(window.document.body).keypress @keypress


      @keypress: (info) =>
          console.log info.which
          switch info.which
              when 115 #s
                  @serialize()
              when 32 #space
                  if @state == "write"
                      @state = "delete"
                  else
                      @state = "write"

                  console.log @state


      @onClick: () =>
          @drawing = true

      @state: "write"

      @serialize:()=>
          result = []
          for tile in @tiles
              i = Math.floor( tile.x / Constants.brick_width)
              j = Math.floor( tile.y / Constants.brick_height)

              result.push [i,j]

          console.log "level infoz"
          console.log JSON.stringify(result)
          

      @onUp: () =>
          @drawing = false

      @onMove: () =>
          pointer = @game.input.activePointer
          i = Math.floor( pointer.x / Constants.brick_width)
          j = Math.floor( pointer.y / Constants.brick_height)

          $("#position").val("#{i},#{j}")
          return unless @drawing
          position = @tileForPosition()

          if @state == "write"
              return if @brickAtPosition(position)

              sprite = @game.add.sprite( position[0] * Constants.brick_width,position[1] * Constants.brick_height, '8x8')
              @tiles.push sprite

              @brickback sprite if @brickback
          else
              pointer = @game.input.activePointer
              for brick in @tiles when brick?.bounds.contains pointer.x, pointer.y
                  @tiles.splice($.inArray(brick, @tiles),1)

                  brick.destroy()



      @tileForPosition: =>
          pointer = @game.input.activePointer
          i = Math.floor( pointer.x / Constants.brick_width)
          j = Math.floor( pointer.y / Constants.brick_height)

          return [i, j]

      @brickAtPosition:(position) =>
          for tile in @tiles
              i = Math.floor( tile.x / Constants.brick_width)
              j = Math.floor( tile.y / Constants.brick_height)

              return true if i == position[0] and j == position[1]

          false




