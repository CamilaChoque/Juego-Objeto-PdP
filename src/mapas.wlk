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
    var property objetos=[]
    var property esObstaculo=false //NUEVO - camila211125
    //var property position  //NUEVO - camila211125
    method generaritems(obj){
             
        }
    method reubicaritems(items){
        items.forEach{a=>a.cambioposicion(3, 1)}
    }
    method aniadirvisuales(){}
    method activarfunciones (puertas, enemigo, personaje){}

    /*method cargageneral(objetos, funciones, posiciones, ticks){
        game.allVisuals().forEach{a=>game.removeVisual(a)}
        var aux = 0
        if(aux.between(0, objetos.size())){
        objetos.get(aux).cambioposicion(posiciones.get(aux).get(0), posiciones.get(aux).get(1)) 
        }
        
        objetos.forEach{a=>game.addVisual(a)}
    }*/
   method cargarEscena(){

    productorDeEscenas.renderizarEsquinas()
   }

   method limpiarSector(){
        game.clear()
        //game.allVisuals().forEach({a=>game.removeVisual(a)})
        //objetos.forEach({obj=>game.removeVisual(obj)})
        //objetos.clear()
        //game.removeTickEvent("seguimiento")
   }

   method cargar(){
        self.limpiarSector()
        self.cargarEscena() //nuevo camila 26/11
         personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        
        game.addVisual(personaje)
   }
} 
object sector1 inherits Sector{
    
   // var posiciones = [[5,0],[10,5],[5,10],[0,5]]
    method cargainicial() {
        
        //borrar mapa anterior
        self.limpiarSector()
        
        self.cargarEscena() //nuevo camila 26/11
        //objetos
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        objetos.add(enemigo_)

        /*const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)*/
        
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        
        //game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()}) //NUEVO - camila211125
    }
   override method cargar() {
        
     //game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        objetos.add(enemigo_)
        /*const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)*/
        
        game.addVisual(enemigo_)
   }
   override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector9,self,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector4,self,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector2,self,game.at(5,1))
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
	//productorDeEscenas.renderizarCon(imgSalida.comun(),ladoAbajo,sector2)
   }
   
   

   
   
}
object sector2 inherits Sector{
    //const property image = imagenComedor
    //const puerta1 = new Puerta() 
    //const puerta1 = new Puerta(position=game.at(5,0)) //NUEVO - camila211125: agregado directo de posiciones
    
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector8,self,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector3,self,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector10,self,game.at(5,1))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoAbajo,sector1,self,game.at(5,10))
   }
}
object sector3 inherits Sector{
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector2,self,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector5,self,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoArriba,null,self,null)
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
	
   }
}
object sector4 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector1,self,game.at(1,5))
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector6,self,game.at(10,5))
        productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoAbajo,sector7,self,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
	
   }
}

object sector5 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector3,self,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
        productorDeEscenas.renderizarVertical(11, paredIzq,(1..10),self)
	
   }
}

object sector6 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector4,self,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10),self)
	
   }
}
       
object sector7 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector4,self,game.at(5,1))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10),self)
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10),self)
	
   }
}

object sector8 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector2,self,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10),self)
	
   }
}
object sector9 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarVertical(11,paredDer,(1..10),self)
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector1,self,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10),self)
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
	
   }
}


object sector10 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoAbajo,sector2,self,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10),self)
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10),self)
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10),self)
        
	
   }
}

 