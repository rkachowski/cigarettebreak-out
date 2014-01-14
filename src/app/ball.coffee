define ["cs!app/gameobject", "cs!app/constants"], (GameObject, Constants) ->
    class Ball extends GameObject
        paddle: 0

        state: "start"

        constructor: (game) ->
            super game,'8x8', 50, 300

        hit: (sprite) =>
            intersection = @sprite.bounds.intersection sprite.bounds

            if intersection.width > intersection.height
                @x_vel *= -1
            else
                @y_vel *= -1



        update:() =>
            switch @state
                when "start"
                    @stick_to_paddle()
                when "play"
                    @bounce_around()

            super

        stick_to_paddle: () =>
            @sprite.x = @paddle.x() + @paddle.sprite.bounds.width / 2
            @sprite.y = @paddle.y() - @sprite.bounds.height

        start:() =>
                @x_vel = -2
                @y_vel = -2

                @state = "play"


        bounce_around: () =>
            @x_vel *= -1 if @sprite.x <= -1
            @x_vel *= -1 if @sprite.x >= Constants.screen_size[0] - @sprite.bounds.width
            @y_vel *= -1 if @sprite.y <= -1
            @y_vel *= -1 if @sprite.y >= Constants.screen_size[1] - @sprite.bounds.height

            if @paddle.sprite.bounds.intersects @sprite.bounds
                @y_vel *= -1
