
import Personajes.personaje.personaje
object inicio{
  var property position = game.at(0,0)
  var property image = "intro.png"
}

object caja{
    var property position = game.origin()
    var property image = "caja1.png"
}

class Obstaculo{
    var property position = game.at(6, 2)
    method cambioposicion(x,y){
      position = game.at(x,y)
    }
    method estaPresente(posVecinoX,posVecinoY){
        const obstaculos = game.allVisuals().filter({visual=>visual.image()=="obstaculo1.png"})
        return obstaculos.any({obstaculo=>obstaculo.position().x()==posVecinoX&&obstaculo.position().y()==posVecinoY})
    }
}
class Puerta inherits Obstaculo{
    var property image = "puerta.png"
    
    method cambiohabitacion(habitacionx) {
      if(game.getObjectsIn(position).contains(personaje)){
        game.removeTickEvent("ch")
        habitacionx.cargar()
        }
    }
    method cambioHabitacion2(habitacionx) {
      game.onCollideDo(personaje, habitacionx.cargar())
    }
}


object imagenHabitacion {
  var property position = game.at(0,0)
  var property image = "habitacionesmejoradascomedor.png"//el nmbre esta mal puesto
}

object imagenSalaSegura {
  var property position = game.at(0,0)
  var property image = "habitacionesmejoradassalasegura.png"//el nmbre esta mal puesto
}

object imagenComedor {
  var property position = game.at(0,0)
  var property image = "habitacionesmejoradascuarto.png"//el nmbre esta mal puesto
}
object imagenPlantacion {
  var property position = game.at(0,0)
  var property image = "habitacionesmejoradasplantacion.png"//el nmbre esta mal puesto
}

