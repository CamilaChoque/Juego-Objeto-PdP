import wollok.game.*
import enemigo.*
import personaje.*

class Proyectil{
   
    var property image
    var property position
    var property direccionActual  

    const property damage 
    const property velocidadViaje

    method mover(){
        position = direccionActual.siguientePosicion(position)
    }

    method evento(){
        return "eventoBala" + self.identity()
    }

    method impacto(){
        game.removeTickEvent(self.evento())
        game.schedule(50, {game.removeVisual(self)})
    }

    method nuevoViaje(direccion){
        direccionActual = direccion

        game.onCollideDo(self, {obj => self.resolverColision(obj)})
        game.onTick(velocidadViaje, self.evento(),
        {self.mover()})
    }

    method resolverColision(obj){
        if(obj.className("Enemigo")){
            obj.recibirDanio(damage)
        }
        self.impacto()
    }
}

// ----------------- TIPOS DE BALA -----------------

class BalaPistola inherits Proyectil(damage = 1, velocidadViaje = 80){
    init{ image = "balaPistola.png"}       
}
class BalaEscopeta inherits Proyectil(damage = 3, velocidadViaje = 150){
    init{ image = "balaEscopeta.png"}
}
class BalaAmetralladora inherits Proyectil(damage = 2, velocidadViaje = 75){
    init{ image = "balaAmetralladora.png"}
}

// ----------------- FABRICAS DE BALAS -----------------

object fabricaBalaPistola {
    method nuevaBala(posicion, direccion) {
        const bala = new BalaPistola()
        bala.position(posicion)
        return bala
    }
}

object fabricaBalaEscopeta {
    method nuevaBala(posicion, direccion) {
        const bala = new BalaEscopeta()
        bala.position(posicion)
        return bala
    }
}

object fabricaBalaAmetralladora {
    method nuevaBala(posicion, direccion) {
        const bala = new BalaAmetralladora()
        bala.position(posicion)
        return bala
    }
}