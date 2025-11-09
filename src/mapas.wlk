import wollok.game.*
import elementos.*
import personaje.*
import enemigo.*
import iniciojuego.*

/*class Mapa{//acá queda pendiente generalizar los metodos de carga de mapas 


method cargar{
    game.allVisuals().forEach({a=>game.removeVisual(a)})
    generaritems
    reubicaritems
    anadirvisuales
    activarfunciones [puertas, enemigo, personaje']
}
} */
object mapa1{//abajo mapa2 arriba mapá
    method cargainicial() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new enemigo()
        const puerta1 = new Puerta() 
        const puerta2 = new Puerta()
        const puerta3 = new Puerta()
        const puerta4 = new Puerta()
        personaje.cambioposicion(
            (-(personaje.position().x())+10),
            (-(personaje.position().y())+10)
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
        game.onTick(400, "seguimiento", {enemigo_.perseguir(personaje)})
        personaje.configurarTeclas()
        game.onTick(100,"ch",{puerta1.cambiohabitacion(mapa2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(mapa3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(mapa4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(mapa5)})
        //game.schedule(5000,{mapa.cargar()})
    }
   method cargar() {
     game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new enemigo()
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
        game.onTick(400, "seguimiento", {enemigo_.perseguir(personaje)})
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
