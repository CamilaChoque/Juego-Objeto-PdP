import wollok.game.*
import balas.*
import posiciones.*

class Arma{
    var property nombre
    var property image
    var property municion               // -1 para infinita
    const property cadencia             // milisegundos entre disparos
    const property fabricaBalas
    

    method tieneMunicion() = municion == -1 or municion > 0

    method puedeDispara() = selft.tieneMunicion()

    method dispararDesde(posicion, direccion){
        if(not tieneMunicion()) return

        if(municion > 0){
            municion = municion - 1
        }

        const bala = fabricaBalas.nuevaBala(posicion, direccion)
        game.addVisual(bala)
        bala.nuevoViaje(direccion)
    }

    method esPistola() = false
}

class Pistola inherits Arma(
        self.nombre("Pistola")
        self.municion(-1)
        self.cadencia(500)
        self.fabricaBalas(fabricaBalaPistola)   
        image = "pistola.png"
){
    override method esPistola() = true
}


class Escopeta inherits Arma (
    self.nombre("Escopeta")
    self.municion(6)
    self.cadencia(800)
    self.fabricaBalas(fabricaBalaEscopeta) 
    image = "escopeta.png"
){}

class Ametralladora inherits Arma (
        self.nombre("Ametralladora")
        self.municion(20)
        self.cadencia(200)
        self.fabricaBalas(fabricaBalaAmetralladora) 
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
        const armaSuelo = new ArmaEnSuelo(arma = arma)
        armaSuelo.position(posicion)
        armaSuelo.image(arma.image())
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
