import src.colisiones.*
import wollok.game.*
import enemigo.*
import Personajes.personaje.*
import Personajes.posiciones.*
import Personajes.armas.*

class Proyectil{
   
    var property image = "bala.png"
    var property position = game.at(0,0)
    var property direccionActual = null
    const property esObstaculo = false

    var property arma = null
    const property velocidadViaje

    method mover(){
        var nuevaPos = direccionActual.siguientePosicion(position)

        var x = nuevaPos.x()
        var y = nuevaPos.y()

        if(posiciones.fueraDelMapa(nuevaPos)){
            self.impacto()
        }

        if(colisiones.hayObstaculoEn(x, y)){
            self.impacto()
        }

        if(colisiones.hayEnemigoEn(x, y)){
            var enemigo = colisiones.enemigos.find({ene => ene.estaEnCelda(x, y)})
            enemigo.recibirDanio(arma.danio())
            self.impacto()
        }
        
        // Si no hay nada -> Se mueve
        position = nuevaPos
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

        game.onTick(velocidadViaje, self.evento(),
        {self.mover()})
    }
}


// ----------------- TIPOS DE BALA -----------------

class BalaPistola inherits Proyectil(velocidadViaje = 30){
    
}
class BalaEscopeta inherits Proyectil(velocidadViaje = 60) {
}
class BalaAmetralladora inherits Proyectil(velocidadViaje = 10) {
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