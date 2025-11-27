import src.mapas.*
import src.elementos.*
import Personajes.personaje.*
class Lado{
  var property rango = [1,2,3,4,7,8,9,10]
  method posiciones()
}
object ladoIzquierdo inherits Lado{
  override method posiciones() = [game.at(0,6),game.at(0,5)]
  //var property imgs=[]
  method renderizar(productor){
    productor.renderizarVertical(0,paredIzq,self.rango()) //se renderiza paredes que ya pertenecen a una
  }
}

object ladoDerecho inherits Lado{
  override method posiciones() = [game.at(11,6), game.at(11,5)]
  //var property imgs=[]
  method renderizar(productor){
    productor.renderizarVertical(11,paredDer,self.rango())
  }
}

object ladoArriba inherits Lado{
  //var property imgs=[]
  override method posiciones() = [game.at(5,11), game.at(6,11)]
  method renderizar(productor){
    productor.renderizarHorizontal(11,paredSuperior,self.rango())
  }
}

object ladoAbajo inherits Lado{
  //var property imgs=[]
  override method posiciones() = [game.at(5,0), game.at(6,0)]
  method renderizar(productor){
    productor.renderizarHorizontal(0,paredInferior,self.rango())
  }
}


object imgSalida{
  var property comun = new Dictionary()
  var property emergencia = new Dictionary()
  var property final = new Dictionary()
  
  method deComun(){
    comun.put(ladoIzquierdo, ["salidaIzq1.png", "salidaIzq2.png"])
    comun.put(ladoDerecho,  ["salidaDer1.png", "salidaDer2.png"])
    comun.put(ladoArriba,   ["salidaArriba1.png", "salidaArriba2.png"])
    comun.put(ladoAbajo,    ["salidaAbajo1.png", "salidaAbajo2.png"])
    return comun
  }
  method deEmergencia(){
    emergencia.put(ladoIzquierdo, ["salidaEIzq1.png", "salidaEIzq2.png"])
    emergencia.put(ladoDerecho,  ["salidaEDer1.png", "salidaEDer2.png"])
    emergencia.put(ladoArriba,   ["salidaEArriba1.png", "salidaEArriba2.png"])
    emergencia.put(ladoAbajo,    ["salidaEAbajo1.png", "salidaEAbajo2.png"])
    return emergencia
  }
  
  method deFinal(){
    final.put(ladoIzquierdo, ["salidaFIzq1.png", "salidaFIzq2.png"])
    final.put(ladoDerecho,  ["salidaFDer1.png", "salidaFDer2.png"])
    final.put(ladoArriba,   ["salidaFArriba1.png", "salidaFArriba2.png"])
    final.put(ladoAbajo,    ["salidaFAbajo1.png", "salidaFAbajo2.png"])
    return final
  }
}

class Salida inherits Obstaculo{
  var property lado=null
  var property imgs=[]
  var property destino=null

  method renderizar(productor){
    lado.renderizar(productor)
  }
  //method cambiarHabitacion(habitacionx) {
    //console.println("accediendo sector2")
    /*if(game.getObjectsIn(position).contains(personaje)){
      game.removeTickEvent("ch")
      habitacionx.cargar()
    }*/
  //}
  method cambiarHabitacion(){
    console.println("accediendo sector2")
    /*if(destino!=null){
      destino.cargar()
    }*/
    
  }
  method analizarCambioSector(){
    game.onCollideDo(personaje,{ =>
            
            self.cambiarHabitacion()
    })
  }
}


/*object comun inherits Obstaculo{
  
  method ladoIzquierdo(destino_){
    self.crearSalida(["salidaIzq1.png","salidaIzq2.png"], ladoIzquierdo, destino_)
  } 
  method ladoDerecho(destino_){
    self.crearSalida(["salidaDer1.png",  "salidaDer2.png"], ladoDerecho, destino_)
  } 
  method ladoArriba(destino_){
    self.crearSalida(["salidaArriba1.png","salidaArriba2.png"], ladoArriba, destino_)
  }
  method ladoAbajo(destino_){
    self.crearSalida(["salidaAbajo1.png", "salidaAbajo2.png"], ladoAbajo, destino_)
  }
}*/
/*object comun inherits Salida{
  method ladoIzquierdo() = new LadoIzquierdo(imgs=["salidaIzq1.png","salidaIzq2.png"]) 
  method ladoDerecho()   = new LadoDerecho(imgs=["salidaDer1.png",  "salidaDer2.png"])
  method ladoArriba()    = new LadoArriba(imgs=["salidaArriba1.png","salidaArriba2.png"])
  method ladoAbajo()     = new LadoAbajo(imgs=["salidaAbajo1.png", "salidaAbajo2.png"])
}*/
/*object emergencia inherits Obstaculo{
  method crearSalida(imgs_,lado_,destino_){
    const salida_=new Salida(imgs=imgs_,lado=lado_,destino=destino_)
    salida_.analizarCambioSector()
    return salida_
  }
  method ladoIzquierdo(destino_){
    self.crearSalida(["salidaEIzq1.png","salidaEIzq2.png"], ladoIzquierdo, destino_)
  } 
  method ladoDerecho(destino_){
    self.crearSalida(["salidaEDer1.png",  "salidaEDer2.png"], ladoDerecho, destino_)
  } 
  method ladoArriba(destino_){
    self.crearSalida(["salidaEArriba1.png","salidaEArriba2.png"], ladoArriba, destino_)
  }
  method ladoAbajo(destino_){
    self.crearSalida(["salidaEAbajo1.png", "salidaEAbajo2.png"], ladoAbajo, destino_)
  }
}*/

/*object final inherits Obstaculo{
  method crearSalida(imgs_,lado_,destino_){
    const salida_=new Salida(imgs=imgs_,lado=lado_,destino=destino_)
    salida_.analizarCambioSector()
    return salida_
  }
  method ladoIzquierdo(destino_){
    self.crearSalida(["salidaFIzq1.png","salidaFIzq2.png"], ladoIzquierdo, destino_)
  } 
  method ladoDerecho(destino_){
    self.crearSalida(["salidaFDer1.png",  "salidaFDer2.png"], ladoDerecho, destino_)
  } 
  method ladoArriba(destino_){
    self.crearSalida(["salidaFArriba1.png","salidaFArriba2.png"], ladoArriba, destino_)
  }
  method ladoAbajo(destino_){
    self.crearSalida(["salidaFAbajo1.png", "salidaFAbajo2.png"], ladoAbajo, destino_)
  }
}*/

