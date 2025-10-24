import wollok.game.*

object posiciones {

  method mover(posicion, velocidad, arriba, abajo, izquierda, derecha) {
    var nueva = posicion

    if (arriba) nueva = nueva.up(velocidad)
    if (abajo) nueva = nueva.down(velocidad)
    if (izquierda) nueva = nueva.left(velocidad)
    if (derecha) nueva = nueva.right(velocidad)

    return nueva
  }

  // Limita la posición dentro del tablero
  method limitarDentroDe(posicion) {
    var x = posicion.x()
    var y = posicion.y()

    if (x < 0) x = 0
    if (y < 0) y = 0
    if (x >= game.width()) x = game.width() - 1
    if (y >= game.height()) y = game.height() - 1

    return game.at(x, y)
  }
}