define ["cs!app/gameobject"], (GameObject) ->
    class Player extends GameObject
        constructor: (game) ->
            super game,'fag', 50, 416


        update: () =>
            pointer = @game.input.activePointer

            @sprite.x = pointer.x - @sprite.bounds.width / 2
