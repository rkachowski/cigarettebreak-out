define ["cs!app/player"], (Player) ->

  class Main
    @setup: =>
        console.log "Ready!"
        @game = new Phaser.Game 800, 600, Phaser.AUTO, $("#game")[0], preload: @preload, create: @create, update: @update


    @preload: =>
        @game.load.image("5x5","images/5x5.jpg")
        console.log "Preload"

    @update: =>

    @create: =>
        console.log "Create"
        @player = new Player(@game)
