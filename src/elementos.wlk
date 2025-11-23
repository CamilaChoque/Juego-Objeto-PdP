
import Personajes.personaje.*
object inicio{
  var property esObstaculo=false
  var property position = game.at(0,0)
  var property image = "intro.png"
}

object caja{
    var property position = game.origin()
    var property image = "caja1.png"
}

class Obstaculo{
    var property position = game.at(6, 2)
    var property image=""
    var property esObstaculo=true
    /*method cambioposicion(x,y){
      position = game.at(x,y)
    }*/
    method estaPresente(posVecinoX,posVecinoY){
        const obstaculos = game.allVisuals().filter({visual=>visual.esObstaculo()})
        return obstaculos.any({obstaculo=>obstaculo.position().x()==posVecinoX&&obstaculo.position().y()==posVecinoY}) //eavluaci+on necesaria para ver si es una celda sin nada o si es de un obstaculo
  }
}
class Puerta inherits Obstaculo{
    override method image() = "puerta.png"
    
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


object imagenHabitacion inherits Obstaculo{ 
  override method position() = game.at(0,0)
  override method image() = "habitacionesmejoradascomedor.png"//el nmbre esta mal puesto
}

object imagenSalaSegura inherits Obstaculo{
  override method position()=game.at(0,0)
  override method image() = "habitacionesmejoradassalasegura.png"//el nmbre esta mal puesto
}

object imagenComedor inherits Obstaculo{
  override method position() = game.at(0,0)
  override method image() = "habitacionesmejoradascuarto.png"//el nmbre esta mal puesto
}
object imagenPlantacion inherits Obstaculo{
  override method position() = game.at(0,0)
  override method image() = "habitacionesmejoradasplantacion.png"//el nmbre esta mal puesto
}

