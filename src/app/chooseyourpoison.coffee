define ["cs!app/player", "cs!app/ball", "cs!app/constants"], (Player, Ball, Constants) ->

  class Main
    @setup: =>
        console.log "Ready!"
        @game = new Phaser.Game Constants.screen_size[0], Constants.screen_size[1],
            Phaser.AUTO, $("#game")[0], preload: @preload, create: @create, update: @update


    @preload: =>
        @game.load.image("5x5","images/5x5.jpg")
        @game.load.image("8x8","images/8x8.jpg")
        console.log "Preload"

    @update: =>
        @player.update()
        @ball.update()



    @create: =>
        console.log "Create"
        @player = new Player(@game)
        @ball = new Ball(@game)

        @ball.paddle = @player

