import wollok.game.*
import posiciones.*
import enemigo.*
import personaje.*
import balas.*

class Arma{
    var property municion       
    const cadencia             // milisegundos entre disparos
    const nombre
    const tipoProyectil
    var property puedeDisparar = true 

    method disparar(desde, direccion){
        if(!puedeDisparar){
            //
        }else{
            //Activo Cooldown
            self.puedeDisparar(false)
            game.schedule(cadencia, {
            self.puedeDisparar(true)
            })

            if(nombre != "Pistola"){
                self.municion(self.municion() - 1)
                if(self.municion() < 0){
                    self.municion(0)
                } else{
                    var proyectil = tipoProyectil.new()
                    proyectil.position(desde)
                    game.addVisual(proyectil)
                    proyectil.nuevoViaje(direccion)
                }
            }else{ //Pistola tiene municion infinita
                var proyectil = tipoProyectil.new()
                proyectil.position(desde)
                game.addVisual(proyectil)
                proyectil.nuevoViaje(direccion)
            }
            
            
            // Si se queda sin municion, volver a pistola
            /*if(nombre != "Pistola" && municion <= 0)
                personaje.volverAPistola()
            }*/

            }
    }
}





