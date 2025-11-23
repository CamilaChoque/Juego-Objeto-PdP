import wollok.game.*
import posiciones.*
import enemigo.*
import personaje.*
import .*

class Arma{
    var property municion      // -1 para infinita
    const cadencia             // milisegundos entre disparos
    const nombre
    const tipoProyectil
    var property puedeDisparar = true 

    method disparar(desde, direccion){
        if(!puedeDisparar){
            //
        } else{
            if(municion == 0){

            } else{

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

                if(municion() == 0 and nombre != "Pistola"){
                    personaje.volverAPistola()
                }
            }
        }     
    }
}

class pistola inherits Arma(
        self.nombre("Pistola")
        self.municion(-1)
        self.cadencia(500)
        self.tipoProyectil(BalaPistola)   
)


class Escopeta inherits Arma (
    self.nombre("Escopeta")
    self.municion(6)
    self.cadencia(800)
    self.tipoProyectil(BalaEscopeta)
)

class Ametralladora inherits Arma (
        self.nombre("Ametralladora")
        self.municion(20)
        self.cadencia(200)
        self.tipoProyectil(BalaAmetralladora)
)

class ArmaEnSuelo{
    var property position
    var property image
    const tipoArma

    method agarrar(){
        personaje.tomarArma(tipoArma)
        game.removeVisual(self)
    }
}



