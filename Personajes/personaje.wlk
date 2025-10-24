import wollok.game.*
import Personajes.posiciones.*

object personaje {

    var property position = game.center()
    var property speed = 1

    var property upPressed = false
    var property downPressed = false
    var property leftPressed = false
    var property rightPressed = false

    //method image() = "player.png"

    method move() {
        position = posiciones.mover(position, speed, upPressed, downPressed, leftPressed, rightPressed)
        position = posiciones.limitarDentroDe(position)
    }
}