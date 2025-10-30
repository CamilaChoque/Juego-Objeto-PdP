import Personajes.personaje.*
import elementos.*
import enemigo.*

object juego{ //si es muy pequeño añadir acá los menus pasando a llamarse "configuración"
    const enemigo_ = new enemigo()
    const invisibleEnemigo = new HitboxEnemigo()
    method iniciar(){
        game.addVisualCharacter(caja)
        game.addVisual(enemigo_)
        game.addVisual(personaje)
        

        [9,10,11,12,13,14,15].forEach({ elemento=>
        //const obstaculoA_ = new Obstaculo()
        const obstaculoB_ = new Obstaculo()
        //obstaculoA_.position(game.at(elemento, 3))
        obstaculoB_.position(game.at(elemento, 9))

        //game.addVisual(obstaculoA_)
        game.addVisual(obstaculoB_)})
        
        [2,3,4,5].forEach({ elemento=>
        const obstaculov_ = new Obstaculo()
        obstaculov_.position(game.at(9, elemento))
        
        
        game.addVisual(obstaculov_)})
        
        
        game.onTick(1000, "seguimiento", {invisibleEnemigo.perseguir(caja)}) //esto actualizar recorrerATomar
        
        
        //game.onTick(1000, "seguimiento", {enemigo_.perseguir(caja)})
    
        
    
    }

    /*method evitar(){
        game.allVisuals().image()=="obstaculo1.png"
        //todos los visuales con esa img vamos a evitarlas ó nos interesará su posición
    }*/

    method estaAlLimite(posX,posY)=game.width()<posX || game.height()<posY || posX<0 || posY<0 //si se pasa del tablero tanto negativo o fuera del rango

/*
    method mover(){
        
        add.visual(personaje.sprite)

        // Tick: mueve continuamente al personaje
        game.onTick(100, "moverPersonaje", { personaje.move() })

        // Controles de teclado WASD
        keyboard.onPressDo("W", { personaje.moverArriba() })
  
        keyboard.onPressDo("S", { personaje.moverAbajo() })

        keyboard.onPressDo("A", { personaje.moverIzquierda() })

        keyboard.onPressDo("D", { personaje.moverDerecha() })


    }
*/
}

    