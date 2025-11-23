import wollok.game.*

object posiciones {

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


object arriba {
  method siguientePosicion(pos) =
    posiciones.limitarDentroDe(game.at(pos.x(), pos.y() - 1))
}

object abajo {
  method siguientePosicion(pos) =
    posiciones.limitarDentroDe(game.at(pos.x(), pos.y() + 1))
}

object izquierda {
  method siguientePosicion(pos) =
    posiciones.limitarDentroDe(game.at(pos.x() - 1, pos.y()))
}

object derecha {
  method siguientePosicion(pos) =
    posiciones.limitarDentroDe(game.at(pos.x() + 1, pos.y()))
}