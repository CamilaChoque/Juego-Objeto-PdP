import wollok.game.*
import elementos.*
import Personajes.personaje.*
import enemigo.*
import juego.*




object sector1 {
        
    method cargainicial() {
        //borrar mapa anterior
        game.clear()
        //objetos
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)

         //NUEVO - camila211125: agregado directo de posiciones
        const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector3) 
        const puerta2 = new Puerta(position=game.at(10,5), sectorSiguiente = sector3)
        const puerta3 = new Puerta(position=game.at(5,10), sectorSiguiente = sector3)
        const puerta4 = new Puerta(position=game.at(0,5), sectorSiguiente = sector3)
        const superviviente = new Superviviente()
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()

       

   
        game.onTick(100,"rescate", {superviviente.rescate(superviviente)})
        game.addVisual(personaje)
        game.addVisual(enemigo_)
        game.addVisual(puerta1)
        game.addVisual(puerta2)
        game.addVisual(puerta3)
        game.addVisual(puerta4)
        game.addVisual(superviviente)
        game.onCollideDo(puerta1, {other => puerta1.cambiohabitacion(sector3)})
        game.onCollideDo(puerta2, {other => puerta2.cambiohabitacion(sector3)})
        game.onCollideDo(puerta3, {other => puerta3.cambiohabitacion(sector3)})
        game.onCollideDo(puerta4, {other => puerta4.cambiohabitacion(sector3)})
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()}) //NUEVO - camila211125
    }
   method cargar() {
     game. clear()
     
        const enemigo_ = new EnemigoCorredor(vida=3,velocidad=50,objetivo=personaje)

         //NUEVO - camila211125: agregado directo de posiciones
        const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector2) 
        const puerta2 = new Puerta(position=game.at(10,5), sectorSiguiente = sector2)
        const puerta3 = new Puerta(position=game.at(5,10), sectorSiguiente = sector2)
        const puerta4 = new Puerta(position=game.at(0,5), sectorSiguiente = sector2)
        const superviviente = new Superviviente()
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------

        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
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
        game.addVisual(superviviente)
        game.onTick(enemigo_.velocidad(), "seguimiento", {enemigo_.perseguir()})
        game.onTick(100,"rescate", {superviviente.rescate()})
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector2)})
        game.onTick(100,"ch",{puerta2.cambiohabitacion(sector3)})
        game.onTick(100,"ch",{puerta3.cambiohabitacion(sector4)})
        game.onTick(100,"ch",{puerta4.cambiohabitacion(sector5)})
   }
}
object sector2 {
    const property image = imagenComedor
    //const puerta1 = new Puerta() 
    const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector4) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game. clear()
        
        //game.allVisuals().clear()
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        game.addVisual(image)
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
        game.addVisual(puerta1)

        
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector4)})
       // personaje.configurarTeclas()
    }
}
object sector3 {
    const property image = imagenSalaSegura
    //const puerta1 = new Puerta() 
    const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector5) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game. clear()
        //game.allVisuals().clear()
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        game.addVisual(image)
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
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector4)})
    }
}
object sector4 {
    const property image = imagenHabitacion
    //const puerta1 = new Puerta() 
    const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector1) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game.clear()
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        game.addVisual(image)
        
        
        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------

        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector5)})
    }
}

object sector5 {
    const property image = imagenPlantacion
    //const puerta1 = new Puerta() 
    
    const puerta1 = new Puerta(position=game.at(5,0), sectorSiguiente = sector3) //NUEVO - camila211125: agregado directo de posiciones
    method cargar() {
        game. clear()
        //game.allVisuals().clear()
        
        personaje.configTeclas()
        personaje.moverContinuo()
        personaje.animacion()
        game.addVisual(image)
        /*personaje.cambioposicion(
            (-(personaje.position().x())+10)*0.9,
            (-(personaje.position().y())+10)*0.9
        )*/
        game.addVisual(personaje)
        //puerta1.cambioposicion(5,0)
        game.addVisual(puerta1)

    
        game.onTick(100,"ch",{puerta1.cambiohabitacion(sector1)})

        //NUEVO - camila211125: agregado directo de posiciones
        const nuevaPos=game.at((-(personaje.position().x())+10),(-(personaje.position().y())+10))
        personaje.position(nuevaPos)
        //------------------
    }
}

        