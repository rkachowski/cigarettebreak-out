define ["cs!app/player", "cs!app/ball", "cs!app/constants", "cs!app/editor", "cs!app/levels"], (Player, Ball, Constants, Editor, Levels) ->

  class Main
    @state: "play"

    @setup: =>
        @updateables = []
        @bricks = []
        @game = new Phaser.Game Constants.screen_size[0], Constants.screen_size[1],
            Phaser.AUTO, $("#game")[0], preload: @preload, create: @create, update: @update

    @preload: =>
        @game.load.image("fag","images/fag.png")
        @game.load.image("8x8","images/8x8.jpg")

    @loadLevel:(levelString) =>
        levelInfo = JSON.parse levelString

        for brick in levelInfo
              sprite = @game.add.sprite( brick[0] * Constants.brick_width, brick[1] * Constants.brick_height, '8x8')
              @bricks.push sprite

    @update: =>
        switch @state
            when "play"
                for updatable in @updateables
                    updatable.update()

                pointer = @game.input.activePointer

                if pointer.justReleased(50)
                    @ball.start()

                @collideBricks()
            when "editor"
                console.log "yeah" if @what


    @collideBricks: () =>

        kill_list = []

        for brick in @bricks
            rect = brick.bounds.intersection @ball.sprite.bounds
            if rect.width > 0 || rect.height > 0
                @ball.hit brick
                kill_list.push brick

        for b in kill_list
            @bricks.splice($.inArray(b, @bricks),1)
            b.destroy()

    @create: =>
        @player = new Player(@game)
        @ball = new Ball(@game)

        @ball.paddle = @player

        @updateables.push  @ball
        @updateables.push @player

        @loadLevel Levels.lungs

        


    @addBrick:(brick) =>
        @bricks.push brick

