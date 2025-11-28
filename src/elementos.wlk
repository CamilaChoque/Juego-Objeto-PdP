
import Personajes.personaje.personaje
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
    var property sectorSiguiente
    method cambiohabitacion(habitacionx) {
      if(game.getObjectsIn(position).contains(personaje)){
        
        habitacionx.cargar()
        }
    }
    method cambioHabitacion2(habitacionx) {
      game.onCollideDo(personaje, habitacionx.cargar())
    }
}

class Puertabloqueada inherits Puerta{}

class Superviviente{
  var property esObstaculo = false
  var property imagen = "amogus.png"
  method image() = imagen
  method position()= game.at(8, 8)
  method rescate(visualsuperviviente) {
    
  if(self.position().distance(personaje.position())<2){
    imagen="amogusE.png"
    keyboard.e().onPressDo{
      game.schedule(100000, game.removeVisual(visualsuperviviente))
      game.removeTickEvent("rescate")
    }
    
    
  }
    else imagen = "amogus.png"
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

