define ["cs!app/player", "cs!app/ball", "cs!app/constants", "cs!app/brick"], (Player, Ball, Constants, Brick) ->

  class Editor
      @tiles: []

      @activate:(@game, @brickback) =>
          $("#game").mousedown @onClick
          $("#game").mousemove @onMove
          $("#game").mouseup @onUp

      @onClick: () =>
          @drawing = true

      @onUp: () =>
          @drawing = false

      @onMove: () =>
          return unless @drawing
          position = @tileForPosition()
          
          return if @brickAtPosition(position)

          sprite = @game.add.sprite( position[0] * Constants.brick_width,position[1] * Constants.brick_height, '8x8')
          @tiles.push sprite

          @brickback sprite if @brickback

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




