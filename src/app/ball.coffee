define ["cs!app/gameobject"], (GameObject) ->
    class Ball extends GameObject
        paddle: 0

        state: "start"

        constructor: (game) ->
            super game,'8x8', 50, 300

        update:() =>
            switch @state
                when "start"
                    @stick_to_paddle()


        stick_to_paddle: () =>
            @sprite.x = @paddle.x() + @paddle.sprite.bounds.width / 2
            @sprite.y = @paddle.y() - @sprite.bounds.height

