import wollok.game.*
import posiciones.*
import enemigo.*
import personaje.*

class Proyectil{
   
    var property image
    var property position
    var property direccionActual     
    const damage 
    const velocidadViaje

    method mover(direccion){
        position = direccion.siguientePosicion(position)
    }

    method evento(){
        return "evento" + self.identity()
    }

    method impacto(){
        game.removeTickEvent(self.evento())
        game.schedule(50, {game.removeVisual(self)})
    }

    method nuevoViaje(direccion){
        direccionActual = direccion

        game.onCollideDo(self, {obj => self.resolverColision(obj)})
        game.onTick(velocidadViaje, self.evento(),
        {self.mover(direccionActual)})
    }

    method resolverColision(obj){
        if(obj.className("Enemigo")){
            obj.recibirDanio(damage)
            self.impacto()
        } else{
            self.impacto()
        }
    }
}

class BalaPistola inherits Proyectil(damage = 1, velocidadViaje = 100){
    override method impacto(){
        self.image("balaPistola.png")
        super()
    }
}

class BalaEscopeta inherits Proyectil(damage = 3, velocidadViaje = 150){
    override method impacto(){
        self.image("balaEscopeta.png")
        super()
    }
}

class BalaAmetralladora inherits Proyectil(damage = 2, velocidadViaje = 75){
    override method impacto(){
        self.image("balaAmetralladora.png")
        super()
    }
}