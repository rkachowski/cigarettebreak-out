define ["cs!app/gameobject", "cs!app/constants"], (GameObject, Constants) ->
    class Brick extends GameObject
        constructor: (game, x, y) ->
            super game,'8x8', x, y

