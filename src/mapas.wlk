import wollok.game.*
import elementos.*
import Personajes.personaje.*
import enemigo.*
import juego.*

class Mapa{//acá queda pendiente generalizar los métodos de carga de mapas 

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
} 
object mapa1 inherits Mapa{
   // var posiciones = [[5,0],[10,5],[5,10],[0,5]]
    method cargainicial() {
        //borrar mapa anterior
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //objetos
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        const puerta1 = new Puerta() 
        const puerta2 = new Puerta()
        const puerta3 = new Puerta()
        const puerta4 = new Puerta()
        //posiciones
        puerta1.cambioposicion(5,0)
        puerta2.cambioposicion(10,5)
        puerta3.cambioposicion(5,10)
        puerta4.cambioposicion(0,5)
        personaje.cambioposicion(
            (-(personaje.position().x())+10),
            (-(personaje.position().y())+10)
        )
        //funciones

        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()})
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()

        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(mapa3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(mapa4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(mapa5)})
        //game.schedule(5000,{mapa.cargar()})
        //visuales
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)
        
    }
   method cargar() {
     game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)
        const puerta1 = new Puerta() 
        const puerta2 = new Puerta()
        const puerta3 = new Puerta()
        const puerta4 = new Puerta()
        personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        puerta1.cambioposicion(5,0)
        puerta2.cambioposicion(10,5)
        puerta3.cambioposicion(5,10)
        puerta4.cambioposicion(0,5)
        game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()})
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(mapa3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(mapa4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(mapa5)})
   }
}
object mapa2{
    const property image = imagenComedor
    const puerta1 = new Puerta() 
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        game.addVisual(image)
        personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )
        game.addVisual(personaje)
        puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa3)})
       // personaje.configurarTeclas()
    }
}
object mapa3{
    const property image = imagenSalaSegura
    const puerta1 = new Puerta() 
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        game.addVisual(image)
        personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )
        game.addVisual(personaje)
        puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa4)})
    }
}
object mapa4{
    const property image = imagenHabitacion
    const puerta1 = new Puerta() 
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        game.addVisual(image)
        personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )
        game.addVisual(personaje)
        puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa5)})
    }
}

object mapa5{
    const property image = imagenPlantacion
    const puerta1 = new Puerta() 
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        game.addVisual(image)
        personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )
        game.addVisual(personaje)
        puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa1)})
    }
}
