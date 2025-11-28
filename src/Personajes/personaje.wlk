import src.elementos.*
import wollok.game.*
import Personajes.posiciones.*
import colisiones.*
import armas.*


object personaje{

    //var property position = game.origin() //recomendado para que funcion el perseguir() del enemigo
    //var property position = game.center()
    var property esObstaculo=false //NUEVO - camila211125
    var property position=game.at(6,6) //NUEVO - camila211125
    const property velocidad = 1
    var property orientacion = 2        // 1: Arriba, 2: Abajo, 3: Izq, 4:Der
    var property estado = true           
     // Para el cambio de sprite

    var property imagen = "astronauta_frente.png"
    method image() = imagen

    // Estado del arma actual
    var property armaActual = new Pistola()
    var property puedeDisparar = true

    // ----------------- MOVIMIENTO -----------------
    method moverArriba(){
        orientacion = 1
        position = posiciones.limitarDentroDe(position.up(velocidad))
        self.actualizarSprite()
    }

    method moverAbajo(){
        orientacion = 2
        position = posiciones.limitarDentroDe(position.down(velocidad))
        self.actualizarSprite()
    }

    method moverIzquierda(){
        orientacion = 3
        position = posiciones.limitarDentroDe(position.left(velocidad))
        self.actualizarSprite()
    }

    method moverDerecha(){
        orientacion = 4
        position = posiciones.limitarDentroDe(position.right(velocidad))
        self.actualizarSprite()
    }

    // ----------------- DISPARO -----------------

    method intentarDisparar(direccion){
        if(not puedeDisparar) return null
        if(not armaActual.puedeDisparar()) return null
        
        armaActual.dispararDesde(position, direccion)

        // Cooldown del arma
        puedeDisparar = false
        game.schedule(armaActual.cadencia(),{ => self.habilitarDisparo()})

        return true
    }

    method habilitarDisparo(){
        puedeDisparar = true
    }

    method dispararArriba(){
        orientacion = 1
        self.intentarDisparar(direccionArriba)
        self.actualizarSprite()
    }
    
    method dispararAbajo(){
        orientacion = 2
        self.intentarDisparar(direccionAbajo)
        self.actualizarSprite()
    }

    method dispararIzquierda(){
        orientacion = 3
        self.intentarDisparar(direccionIzquierda)
        self.actualizarSprite()
    }

    method dispararDerecha(){
        orientacion = 4
        self.intentarDisparar(direccionDerecha)
        self.actualizarSprite()
    }

    // ----------------- ARMAS -----------------
    method aplicarMejoraDeArma(){
        armaActual.mejorar()
    }
    // Q -> Suelta el arma en el suelo, vuelve a la pistola
    method dejarArma(){
        if(armaActual.esPistola()){
            // No se puede tirar la pistola
            return false
            
        }

        armasMundo.dejarArma(position, armaActual)
        armaActual = new Pistola()
        return true
    }

    // E -> Recoje/Intercambia arma con la del piso
    method intentarTomarArma(){
        const armaSuelo = armasMundo.armaEn(position)
        if (armaSuelo == null) return null

        var armaDeSuelo = armaSuelo.arma()

        // Si el arma que tengo no es la pistola, la dejo en el piso
        if(not armaActual.esPistola()){
            armasMundo.dejarArma(position, armaActual)
        }

        self.armaActual(armaDeSuelo)
        armasMundo.eliminar(armaSuelo)
        return true
    }

    method configTeclas(){

        //------- MOVIMIENTO CON WASD -------
        keyboard.w().onPressDo({ self.moverArriba()})
        keyboard.s().onPressDo({ self.moverAbajo()})
        keyboard.a().onPressDo({ self.moverIzquierda()})
        keyboard.d().onPressDo({ self.moverDerecha()})

        //------- DISPARO CON FLECHAS -------
        keyboard.up().onPressDo({ self.dispararArriba()})
        keyboard.down().onPressDo({ self.dispararAbajo()})
        keyboard.left().onPressDo({ self.dispararIzquierda()})
        keyboard.right().onPressDo({ self.dispararDerecha()})

        //------- MANEJO DE ARMAS Q/E -------
        keyboard.q().onPressDo({ self.dejarArma()})
        keyboard.e().onPressDo({ self.intentarTomarArma()})
    }
 
    method spriteOrientacion(){
        if(orientacion == 1) return "arriba"
                else if(orientacion == 2) return "abajo"
                else if(orientacion == 3) return "izquierda"
                else return "derecha"
    }

    method actualizarSprite(){
        const orient = self.spriteOrientacion()
        const nombreArma = armaActual.nombre()

        imagen = "astronauta_" + orient + "_" + nombreArma + ".png"
    }
    /*
    method animacion() {
	  	game.onTick(400, "animacion", { => 
            self.estados()
        })
	}

	method estados() {//cambiar todos los atributos modificados a self.atributo() para evitar errores en ejeucución
		if (self.orientacion() == 1) 		// arriba
			self.cambioDeSprite("astronauta_detras.png", "astronauta_detras.png")
		else if (self.orientacion() == 2) 	// abajo
			self.cambioDeSprite("astronauta_frente.png", "astronauta_frente.png")
		else if (self.orientacion() == 3) 	// izquierda
			self.cambioDeSprite("astronauta_izquierda.png", "astronauta_izquierda.png")
		else if (self.orientacion() == 4) 	// derecha
			self.cambioDeSprite("astronauta_derecha.png", "astronauta_derecha.png")
	}

	method cambioDeSprite(imagen1, imagen2) {
	  	if (self.estado()) {
			self.imagen(imagen1) 
			self.estado(!self.estado()) 
		} else {
			self.imagen(imagen2) 
			self.estado(!self.estado())
		}
	}*/
}