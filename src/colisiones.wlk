import wollok.game.*
//import elementos.*

object colisiones{
    var property obstaculos = [] 
    var property enemigos = []

    method agregarObstaculo(obstaculo) = obstaculos.add(obstaculo)
    method agregarEnemigo(enemigo) = enemigos.add(enemigo)

   method hayObstaculoEn(posX, posY){
        return obstaculos.any({obstaculo => obstaculo.estaEnCelda(posX, posY) })
    }

    method hayEnemigoEn(posX, posY){
        return enemigos.any({enemigo => enemigo.estaEnCelda(posX, posY)})
    }
}