import wollok.game.*
import elementos.*
import Personajes.personaje.*
import enemigo.*
import juego.*
import escenografia.*
import salida.*

class Nivel{

}
class Sector{//acá queda pendiente generalizar los métodos de carga de mapas 
    var property esObstaculo=false //NUEVO - camila211125
    //var property position  //NUEVO - camila211125
    method generaritems(obj){
             
        }
    method reubicaritems(items){
        items.forEach{a=>a.cambioposicion(3, 1)}
    }
    method aniadirvisuales(){}
    method activarfunciones (puertas, enemigo, personaje){}

    method cargageneral(objetos, funciones, posiciones, ticks){
        game.allVisuals().forEach{a=>game.removeVisual(a)}
        var aux = 0
        if(aux.between(0, objetos.size())){
        objetos.get(aux).cambioposicion(posiciones.get(aux).get(0), posiciones.get(aux).get(1)) 
        }
        
        objetos.forEach{a=>game.addVisual(a)}
    }

    //method crearSalida(tipo,lado_,destino_)=new Salida(imgs=tipo.get(lado_),lado=lado_,destino=destino_)
    //camila 26/11
   method cargarEscena(){

    productorDeEscenas.renderizarEsquinas()
    
    /*game.onTick(100,"ch",{puerta1.cambiohabitacion(sector2)})
    game.onTick(100,"ch",{puerta2.cambiohabitacion(sector3)})
    game.onTick(100,"ch",{puerta3.cambiohabitacion(sector4)})
    game.onTick(100,"ch",{puerta4.cambiohabitacion(sector5)})*/
   }
} 
object sector1 inherits Sector{
   // var posiciones = [[5,0],[10,5],[5,10],[0,5]]
    method cargainicial() {
        
        //borrar mapa anterior
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        self.cargarEscena() //nuevo camila 26/11
        //objetos
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)

         //no habra puertaas
        /*const puerta1 = new Puerta(position=game.at(5,0)) 
        const puerta2 = new Puerta(position=game.at(10,5))
        const puerta3 = new Puerta(position=game.at(5,10))
        const puerta4 = new Puerta(position=game.at(0,5))*/
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------
        
        
        //posiciones-lo que se descartó:
        /*puerta1.cambioposicion(5,0)
        puerta2.cambioposicion(10,5)
        puerta3.cambioposicion(5,10)
        puerta4.cambioposicion(0,5)
        personaje.cambioposicion(
            (-(personaje.position().x())+10),
            (-(personaje.position().y())+10)
        )*/
        //funciones

        
        
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()

        //esta en funcion cargarEscena
        /*game.onTick(100,"ch",{puerta1.cambiohabitacion(sector2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(sector3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(sector4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(sector5)})*/
        //game.schedule(5000,{mapa.cargar()})
        //visuales
        
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        /*game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)*/
        
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()}) //NUEVO - camila211125
    }
   method cargar() {
     game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)

         //NUEVO - camila211125: agregado directo de posiciones
        const puerta1 = new Puerta(position=game.at(5,0)) 
        const puerta2 = new Puerta(position=game.at(10,5))
        const puerta3 = new Puerta(position=game.at(5,10))
        const puerta4 = new Puerta(position=game.at(0,5))
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------

        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        /*puerta1.cambioposicion(5,0)
        puerta2.cambioposicion(10,5)
        puerta3.cambioposicion(5,10)
        puerta4.cambioposicion(0,5)*/
        game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()})
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(sector3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(sector4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(sector5)})
   }
   override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector4)
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector9)
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector2)
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
	//productorDeEscenas.renderizarCon(imgSalida.comun(),ladoAbajo,sector2)
   }
   

   
   
}
object sector2 inherits Sector{
    //const property image = imagenComedor
    //const puerta1 = new Puerta() 
    //const puerta1 = new Puerta(position=game.at(5,0)) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        self.cargarEscena() //nuevo camila 26/11
        //game.allVisuals().clear()
        
        //game.addVisual(image)
        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/
        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //-----------------
        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        //game.addVisual(puerta1)

        
        //game.onTick(100,"ch",{puerta1.cambiohabitacion(sector4)})
       // personaje.configurarTeclas()
    }
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.comun(),ladoDerecho,sector8)
	productorDeEscenas.renderizarCon(imgSalida.comun(),ladoIzquierdo,sector3)
	productorDeEscenas.renderizarCon(imgSalida.comun(),ladoArriba,sector10)
	productorDeEscenas.renderizarCon(imgSalida.comun(),ladoAbajo,sector1)
   }
}
object sector3 inherits Sector{
    //const property image = imagenSalaSegura
    //const puerta1 = new Puerta() 
    //const puerta1 = new Puerta(position=game.at(5,0)) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})

        self.cargarEscena() //nuevo camila 26/11
        //game.allVisuals().clear()
        //game.addVisual(image)
        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/

        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------

        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        //game.addVisual(puerta1)
        //game.onTick(100,"ch",{puerta1.cambiohabitacion(sector4)})
    }
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector2)
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector5)
	productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoArriba,null)
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
	
   }
}
object sector4 inherits Sector{
    //const property image = imagenHabitacion
    //const puerta1 = new Puerta() 
    //const puerta1 = new Puerta(position=game.at(5,0)) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        self.cargarEscena()
        //game.addVisual(image)
        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/
        
        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------

        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        //game.addVisual(puerta1)
        //game.onTick(100,"ch",{puerta1.cambiohabitacion(sector5)})
    }
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector1)
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector6)
        productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoAbajo,sector7)
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
	
   }
}

object sector5 inherits Sector{

}

object sector6 inherits Sector{

}
       
object sector7 inherits Sector{

}

object sector8 inherits Sector{

}
object sector9 inherits Sector{
    const property image = imagenPlantacion
    //const puerta1 = new Puerta() 
    
    //const puerta1 = new Puerta(position=game.at(5,0)) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        self.cargarEscena()

        game.addVisual(image)
        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/
        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        //game.addVisual(puerta1)

    
        //game.onTick(100,"ch",{puerta1.cambiohabitacion(sector1)})

        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------
    }
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarVertical(11,paredDer,(1..10))
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector1)
        productorDeEscenas.renderizarHorizontal(11, paredInferior,(1..10))
        productorDeEscenas.renderizarHorizontal(0, paredSuperior,(1..10))
	
   }
}


object sector10 inherits Sector{

}

 