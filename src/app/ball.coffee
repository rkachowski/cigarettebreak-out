define ["cs!app/gameobject", "cs!app/constants"], (GameObject, Constants) ->
    class Ball extends GameObject
        paddle: 0

        state: "start"

        constructor: (game) ->
            super game,'8x8', 50, 300
            @trail = []

        hit: (sprite) =>
            s1hw = @sprite.bounds.width / 2
            s2hw = sprite.bounds.width / 2
            x_distance = Math.abs( @sprite.x - sprite.x)
            x_projection = Math.abs((s1hw + s2hw) - x_distance)
            
            s1hh = @sprite.bounds.height / 2
            s2hh = sprite.bounds.height / 2
            y_distance = Math.abs( @sprite.y - sprite.y)
            y_projection = Math.abs((s1hh + s2hh) - y_distance)

            if x_projection < y_projection
                @sprite.x += x_projection if sprite.x < @sprite.x
                @sprite.x -= x_projection if sprite.x > @sprite.x
                @x_vel *= -1
            else
                @sprite.y += y_projection if sprite.y < @sprite.y
                @sprite.y -= y_projection if sprite.y > @sprite.y
                @y_vel *= -1

        update:() =>
            switch @state
                when "start"
                    @stick_to_paddle()
                when "play"
                    @bounce_around()

            super
            @updateTrail()

        stick_to_paddle: () =>
            @sprite.x = @paddle.x() + @paddle.sprite.bounds.width / 2
            @sprite.y = @paddle.y() - @sprite.bounds.height

            for sprite in @trail
                sprite.x = @sprite.x
                sprite.y = @sprite.y

        start:() =>
                @x_vel = -Constants.speed
                @y_vel = -Constants.speed

                @state = "play"


        bounce_around: () =>
            @x_vel *= -1 if @sprite.x <= -1
            @x_vel *= -1 if @sprite.x >= Constants.screen_size[0] - @sprite.bounds.width
            @y_vel *= -1 if @sprite.y <= -1
            @y_vel *= -1 if @sprite.y >= Constants.screen_size[1] - @sprite.bounds.height

            if @paddle.sprite.bounds.intersects @sprite.bounds
                @y_vel *= -1

        updateTrail: () =>

