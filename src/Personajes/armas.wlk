import wollok.game.*
import balas.*
import posiciones.*

class Arma{
    var property nombre
    var property image
    var property municion               // -1 para infinita
    const property cadencia             // milisegundos entre disparos
    const property fabricaBalas
    const property esObstaculo = false
    

    method tieneMunicion() = municion == -1 or municion > 0

    method puedeDisparar() = self.tieneMunicion()

    method dispararDesde(posicion, direccion){
        if(not self.tieneMunicion()) return false

        if(self.municion() > 0){
            self.municion(self.municion()-1)
        }

        const bala = fabricaBalas.nuevaBala(posicion, direccion)
        game.addVisual(bala)
        bala.nuevoViaje(direccion)
        game.sound("pistola.mp3").play()
        return true
    }

    method esPistola() = false
}

class Pistola inherits Arma(
    nombre = "Pistola",
    municion = -1,
    cadencia = 500,
    fabricaBalas = fabricaBalaPistola,
    image = "pistola.png"
){
    override method esPistola() = true
}


class Escopeta inherits Arma (
    nombre = "Escopeta",
    municion = 6,
    cadencia = 800,
    fabricaBalas = fabricaBalaEscopeta,
    image = "escopeta.png"
){}

class Ametralladora inherits Arma (
    nombre = "Ametralladora",
    municion = 20,
    cadencia = 200,
    fabricaBalas = fabricaBalaAmetralladora,
    image = "ametralladora.png"
){}

class ArmaEnSuelo{
    var property position
    var property image
    var property arma           // Arma real (Escopeta o Ametralladora)
}


// ----------------- REGISTRO GLOBAL ARMAS EN EL PISO -----------------

object armasMundo{

    var property armasSuelo = []

    method dejarArma(posicion, arma) {
        const armaSuelo = new ArmaEnSuelo(
        position = posicion,
        image = arma.image(),
        arma = arma
        )
        armasSuelo.add(armaSuelo)
        game.addVisual(armaSuelo)
    }

    method eliminar(armaSuelo) {
        armasSuelo.remove(armaSuelo)
        game.removeVisual(armaSuelo)
    }

    method armaEn(posicion) {
        return armasSuelo.find({ arma =>
            arma.position().x() == posicion.x()
            && arma.position().y() == posicion.y()
        })
    }
}
