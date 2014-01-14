define ["cs!app/gameobject"], (GameObject) ->
    class Player extends GameObject
        constructor: (game) ->
            super game,'8x8', 50, 416

            @scale 7, 1

        update: () =>
            pointer = @game.input.activePointer

            @sprite.x = pointer.x - @sprite.bounds.width / 2

