
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

object esquinaInfIzq inherits Obstaculo{
  override method image() = "esquina1.png"
  override method position() = game.at(0,0)
}
object esquinaInfDer inherits Obstaculo{
  override method image()= "esquina2.png"
  override method position() = game.at(11,0)
}
object esquinaSupIzq inherits Obstaculo{
  override method image()= "esquina3.png"
  override method position() = game.at(0,11)
}
object esquinaSupDer inherits Obstaculo{
  override method image()= "esquina4.png"
  override method position()= game.at(11,11)
}

object paredSuperior inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredSup.png",position=game.at(1,11))
  }
}
object paredInferior inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredInf.png",position=game.at(1,0))
  }
}
object paredDer inherits Obstaculo{
    method generar(){
    return new Obstaculo(image="paredDer.png",position = game.at(11,1))
  }
}

object paredIzq inherits Obstaculo{
   method generar(){
    return new Obstaculo(image="paredIzq.png",position=game.at(0,1))
  }
}


//esta puesto en logica SALIDA.wlk - nuevo camila 26/11
/*class Puerta inherits Obstaculo{
    override method image() = []
    
    method cambiohabitacion(habitacionx) {
      if(game.getObjectsIn(position).contains(personaje)){
        game.removeTickEvent("ch")
        habitacionx.cargar()
        }
    }
    method cambioHabitacion2(habitacionx) {
      game.onCollideDo(personaje, habitacionx.cargar())
    }
}*/


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

