define [], () ->
    class Player
        constructor: (game) ->
            #create a sprite
            #
            @sprite = game.add.sprite( 50, 300, '5x5')

            @sprite.scale = new Phaser.Point( 10, 2)

        update: () =>
            console.log "lol"

