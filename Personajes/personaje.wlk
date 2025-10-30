import wollok.game.*
import Personajes.posiciones.*

object personaje {

    var property position = game.center()
    const property velocidad = 1
    var property orientacion = 1
    var property estado = 1

    var property imagen = "astronauta_frente.png"
    method image() = imagen

    method movilidad(){

        // Teclas WASD
        // Arriba (W)
        keyboard.w().onPressDo({
            self.position(self.position().up(velocidad))
            imagen = "astronauta_detras.png"
            orientacion = 1
        })

        // Abajo (S)
        keyboard.s().onPressDo({
            self.position(self.position().down(velocidad))
            imagen = "astronauta_frente.png"
            orientacion = 2
        })

        // Izquierda (A)
        keyboard.a().onPressDo({
            self.position(self.position().left(velocidad))
            imagen = "astronauta_izquierda.png"
            orientacion = 3
        })

        // Derecha (D)
        keyboard.d().onPressDo({
            self.position(self.position().right(velocidad))
            imagen = "astronauta_derecha.png"
            orientacion = 4
        })
    }
    method animacion() {
	  	game.onTick(400, "estados", { => self.estados() })
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