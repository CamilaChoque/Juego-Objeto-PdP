import wollok.game.*
import posiciones.*
import enemigo.*
import personaje.*
import balas.*

class Arma{
    var property municion      // -1 para infinita
    const cadencia             // milisegundos entre disparos
    const nombre
    const tipoProyectil
    var property puedeDisparar = true 

    method disparar(desde, direccion){
        if(!puedeDisparar){
            //
        }

        if(municion == 0){

        }

        // Dispara y se activa el Cooldown
        self.puedeDisparar(false)
        game.schedule(cadencia, 
        {self.puedeDisparar(true)})

        if(municion > 0){
            self.municion(self.municion() - 1)
        }

        // Crear el proyectil
        var proyectil = tipoProyectil.new()
        proyectil.position(desde)
        game.addVisual(proyectil)
        proyectil.nuevoViaje(direccion)

        return proyectil
    }
}

object pistola inherits Arma{
    init{
        self.nombre("Pistola")
        self.municion(-1)
        self.cadencia(500)
        self.tipoProyectil(Bala)
    }
}


object Escopeta inherits Arma {
    init {
        self.nombre("Escopeta")
        self.municion(6)
        self.cadencia(800)
        self.tipoProyectil(Bala)
    }
}

object Ametralladora inherits Arma {
    init {
        self.nombre("Ametralladora")
        self.municion(20)
        self.cadencia(200)
        self.tipoProyectil(Bala)
    }
}




