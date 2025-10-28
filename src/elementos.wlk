import personaje.personaje
import mapas.mapa2

object inicio{
  var property position = game.at(0,0)
  var property image = "intro.png"
}

object caja{
    var property position = game.origin()
    var property image = "caja1.png"
}

class Obstaculo{
    var property position=game.at(6, 2)
    method cambioposicion(x,y){
      position = game.at(x,y)
    }
    
}
class Puerta inherits Obstaculo{
    var property image = "puerta.png"
    
    method cambiohabitacion() {
      if(game.getObjectsIn(position).contains(personaje)){mapa2.cargar() game.removeTickEvent("ch")}
    }
}


object dados {
  var property position = game.at(0,0)
  var property image = "habitacionessoracama.png"
}