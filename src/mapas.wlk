import src.hud.*
import src.Personajes.posiciones.*
import wollok.game.*
import elementos.*
import Personajes.personaje.*
import enemigo.*
import juego.*
import escenografia.*
import salida.*
import Personajes.armas.*
import colisiones.*

class Nivel{

}
class Sector{
    var property esObstaculo=false //NUEVO - camila211125
    
    method generarPosicionLibreRandom(){
        var posicionesLibres = []

        var xs = [1,2,3,4,5,6,7,8,9,10]
        var ys = [1,2,3,4,5,6,7,8,9,10]

        xs.forEach{x =>
            ys.forEach{y =>
                const ocupado = game.allVisuals().any({
                    visual =>
                        visual.position().x() == x and
                        visual.position().y() == y
                })
                if(not ocupado){
                    posicionesLibres.add(game.at(x,y))
                }
            }
        }
        return posicionesLibres.anyOne()
    }

    method generarArmas(){
        var cantidadArmas = [0,1,2]
        var tipoArma = ["escopeta", "ametralladora"]

        var cantArma = cantidadArmas.anyOne()

        cantArma.times({_ =>
            var tipo = tipoArma.anyOne()
            var arma = null

            if(tipo == "escopeta"){
                arma = new Escopeta()
            } else {
                arma = new Ametralladora()
            }

            var pos = self.generarPosicionLibreRandom()

            armasMundo.dejarArma(pos, arma)
        })
    }
    
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
        game.addVisual(hudVidas)
   }

   method cargar(){
        self.limpiarSector()
        self.cargarEscena() 
        self.generarArmas()

        personaje.configTeclas()
        
        game.addVisual(personaje)
   }
} 
object sector1 inherits Sector{
    method cargainicial() {
        self.limpiarSector()
        
        self.cargarEscena() 
        self.generarArmas()
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        
        
        personaje.configTeclas()
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        
        
    }
   override method cargar() {
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        game.addVisual(enemigo_)
   }
   override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector9,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector4,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoArriba,sector2,game.at(5,1))
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
   }
}
object sector2 inherits Sector{
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector8,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector3,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoArriba,sector10,game.at(5,1))
	productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoAbajo,sector1,game.at(5,10))
   }
}
object sector3 inherits Sector{
    override method cargarEscena(){
    super()
    productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector2,game.at(1,5))
	productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoIzquierdo,sector5,game.at(10,5))
	productorDeEscenas.renderizarCon(imgSalida.deFinal(),ladoArriba,null,null)
    productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
	
   }
}
object sector4 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoDerecho,sector1,game.at(1,5))
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoIzquierdo,sector6,game.at(10,5))
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoAbajo,sector7,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
	
   }
}

object sector5 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector3,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
}

object sector6 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoDerecho,sector4,game.at(1,5))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
}
       
object sector7 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoArriba,sector4,game.at(5,1))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
	
   }
}

object sector8 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector2,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
	
   }
}
object sector9 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarVertical(11,paredDer,(1..10))
        productorDeEscenas.renderizarCon(imgSalida.deComun(),ladoIzquierdo,sector1,game.at(10,5))
        productorDeEscenas.renderizarHorizontal(0, paredInferior,(1..10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
	
   }
}


object sector10 inherits Sector{
    override method cargarEscena(){
        super()
        productorDeEscenas.renderizarCon(imgSalida.deEmergencia(),ladoAbajo,sector2,game.at(5,10))
        productorDeEscenas.renderizarHorizontal(11, paredSuperior,(1..10))
        productorDeEscenas.renderizarVertical(0, paredIzq,(1..10))
        productorDeEscenas.renderizarVertical(11, paredDer,(1..10))
   }
}

 