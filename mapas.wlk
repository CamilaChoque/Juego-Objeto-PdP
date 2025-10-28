import wollok.game.*
import elementos.*
import personaje.*
import enemigo.*
import juego.*


object mapainicial{
    method carga1() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        const enemigo_ = new enemigo()
        const puerta1 = new Puerta() 
        const puerta2 = new Puerta()
        const puerta3 = new Puerta()
        const puerta4 = new Puerta()
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
        game.onTick(100,"ch",{puerta1.cambiohabitacion()})
        //game.schedule(5000,{mapa.cargar()})
    }
}
object mapa2{
    const property image = dados
    const puerta1 = new Puerta() 
    method cargar() {
        game.allVisuals().forEach({a=>game.removeVisual(a)})
        //game.allVisuals().clear()
        game.addVisual(image)
        puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.addVisual(personaje)
        game.onTick(100,"ch",{puerta1.cambiohabitacion()})
       // personaje.configurarTeclas()
    }
}

