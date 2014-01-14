define ["cs!app/player", "cs!app/ball", "cs!app/constants", "cs!app/editor"], (Player, Ball, Constants, Editor) ->

  class Main
    @setup: =>
        console.log "Ready!"
        @updateables = []
        @game = new Phaser.Game Constants.screen_size[0], Constants.screen_size[1],
            Phaser.AUTO, $("#game")[0], preload: @preload, create: @create, update: @update

    @preload: =>
        @game.load.image("5x5","images/5x5.jpg")
        @game.load.image("8x8","images/8x8.jpg")
        console.log "Preload"

    @update: =>
        for updatable in @updateables
            updatable.update()

        pointer = @game.input.activePointer

        if pointer.justReleased(50)
            @ball.start()

    @create: =>
        @player = new Player(@game)
        @ball = new Ball(@game)

        @ball.paddle = @player

        @updateables.push  @ball
        @updateables.push @player

        Editor.activate @game

