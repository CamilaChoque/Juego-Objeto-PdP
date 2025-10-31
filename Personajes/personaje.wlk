import wollok.game.*
import Personajes.posiciones.*

object personaje {

    var property position = game.center()
    const property velocidad = 1
    var property orientacion = 1        // 1: Arriba, 2: Abajo, 3: Izq, 4:Der
    var property estado = 1             // Para el cambio de sprite

    var property imagen = "astronauta_frente.png"
    method image() = imagen
    
    //Variables para movimiento
    var property mueveArriba = false
    var property mueveAbajo = false
    var property mueveIzq = false
    var property mueveDer = false

    method configTeclas(){

        // Teclas WASD
        //------- PRESIONO TECLA -------
        // Arriba (W)
        
        keyboard.w().onPressDo({
            mueveArriba = true
            imagen = "astronauta_detras.png"
            orientacion = 1
        })

        // Abajo (S)
        keyboard.s().onPressDo({
            mueveAbajo = true
            imagen = "astronauta_frente.png"
            orientacion = 2
        })

        // Izquierda (A)
        keyboard.a().onPressDo({
            mueveIzq = true
            imagen = "astronauta_izquierda.png"
            orientacion = 3
        })

        // Derecha (D)
        keyboard.d().onPressDo({
            mueveDer = true
            imagen = "astronauta_derecha.png"
            orientacion = 4
        })
    }
 
 
    method mover(){
        if(mueveArriba) self.position(self.position().up(velocidad))
        if(mueveAbajo) self.position(self.position().down(velocidad))
        if(mueveIzq) self.position(self.position().left(velocidad))
        if(mueveDer) self.position(self.position().right(velocidad))

        mueveArriba = false
        mueveAbajo = false
        mueveDer = false
        mueveIzq = false

        self.position(posiciones.limitarDentroDe(self.position()))
    }

    method moverContinuo(){
        
        game.onTick(40, "movilidadPersonaje", { => 
            self.mover()
            self.configTeclas()
        })
            
    }

    method animacion() {
	  	game.onTick(400, "animacion", { => 
            if(!mueveArriba && !mueveAbajo && !mueveIzq && !mueveDer){
                self.estados()
            } 
        })
	}

	method estados() {
		if (orientacion == 1) 		// arriba
			self.CambioDeSprite("astronauta_detras.png", "astronauta_detras.png")
		else if (orientacion == 2) 	// abajo
			self.CambioDeSprite("astronauta_frente.png", "astronauta_frente.png")
		else if (orientacion == 3) 	// izquierda
			self.CambioDeSprite("astronauta_izquierda.png", "astronauta_izquierda.png")
		else if (orientacion == 4) 	// derecha
			self.CambioDeSprite("astronauta_derecha.png", "astronauta_derecha.png")
	}

	method CambioDeSprite(imagen1, imagen2) {
	  	if (estado) {
			imagen = imagen1
			estado = !estado
		} else {
			imagen = imagen2
			estado = !estado
		}
	}
}