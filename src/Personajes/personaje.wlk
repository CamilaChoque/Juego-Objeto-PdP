import src.elementos.*
import wollok.game.*
import Personajes.posiciones.*
import colisiones.*
import armas.*

object personaje{

    //var property position = game.origin() //recomendado para que funcion el perseguir() del enemigo
    //var property position = game.center()
    var property esObstaculo=false //NUEVO - camila211125
    var property position=game.at(11,11) //NUEVO - camila211125
    const property velocidad = 1
    var property orientacion = 1        // 1: Arriba, 2: Abajo, 3: Izq, 4:Der
    var property estado = true           
     // Para el cambio de sprite

    var property imagen = "astronauta_frente.png"
    method image() = imagen

    // Arma predefinida, la pistola
    var property armaActual = new Pistola()
    
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
            self.mueveArriba(true)
            self.imagen("astronauta_detras.png")
            self.orientacion(1) 
        })

        // Abajo (S)
        keyboard.s().onPressDo({
            self.mueveAbajo (true)
            self.imagen ("astronauta_frente.png")
            self.orientacion(2) 
        })

        // Izquierda (A)
        keyboard.a().onPressDo({
            self.mueveIzq (true)
            self.imagen ("astronauta_izquierda.png")
            self.orientacion(3) 
        })

        // Derecha (D)
        keyboard.d().onPressDo({
            self.mueveDer (true)
            self.imagen ("astronauta_derecha.png")
            self.orientacion(4) 
        })
    }
 
 
    method mover(){
        var x = self.position().x()
        var y = self.position().y()

        if(mueveArriba){
            const destinoY = y - velocidad
            self.position(self.position().up(velocidad))
            /*if(!colisiones.hayObstaculoEn(x, destinoY)){
                self.position(self.position().up(velocidad))
            }*/
        }
        if(mueveAbajo){
            const destinoY = y + velocidad
            self.position(self.position().down(velocidad))
            /*if(!colisiones.hayObstaculoEn(x, destinoY)){
                self.position(self.position().down(velocidad))
            }*/
        }

        if(mueveIzq){
            const destinoX = x - velocidad
            self.position(self.position().left(velocidad))   
            /*if(!colisiones.hayObstaculoEn(destinoX, y)){
                self.position(self.position().left(velocidad))    
            }*/
        }
        if(mueveDer){
            const destinoX = x + velocidad
            self.position(self.position().right(velocidad))
            /*if(!colisiones.hayObstaculoEn(destinoX, y)){
                self.position(self.position().right(velocidad))
            }*/
        }
        
        self.mueveArriba (false)
        self.mueveAbajo (false)
        self.mueveDer (false)
        self.mueveIzq (false)

        self.position(posiciones.limitarDentroDe(self.position()))
    }

    method moverContinuo(){
        
        game.onTick(40, "movilidadPersonaje", { => 
            self.mover()
        })
            
    }

    method animacion() {
	  	game.onTick(400, "animacion", { => 
            if(!mueveArriba && !mueveAbajo && !mueveIzq && !mueveDer){
                self.estados()
            } 
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
	}
}