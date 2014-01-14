define [], () ->
    class GameObject
        constructor: (game, image, x, y) ->
            #create a sprite
            #
            @sprite = game.add.sprite( 0, 0, image)

            @sprite.scale = new Phaser.Point( 1, 1)
            @game = game

            @x(x)
            @y(y)

        sprite: @sprite

        scale: (x,y) =>
            @sprite.scale = new Phaser.Point(x,y) if x and y
            @sprite.scale

        x:(x) =>
            @sprite.x = x if x
            @sprite.x

        y:(y) =>
            @sprite.y = y if y
            @sprite.y

        position:(x,y) =>
            if x and y
                @sprite.x = x
                @sprite.y = y

            [@sprite.x, @sprite.y]
            
            
        x_vel: 0
        y_vel: 0

        update: () =>
            @update_kinematics()

        update_kinematics:() =>
            @sprite.x += @x_vel
            @sprite.y += @y_vel
