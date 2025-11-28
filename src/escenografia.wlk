import src.elementos.*
import salida.*




object productorDeEscenas{
  var property objetos = []
  method renderizarEsquinas(){
    game.addVisual(esquinaInfIzq)
    game.addVisual(esquinaInfDer)
    game.addVisual(esquinaSupIzq)
    game.addVisual(esquinaSupDer)
  }


  method renderizarVertical(posX,pared,rango,sector){ //izq o der
      rango.forEach({posY=>
          const pared_nuevo=pared.generar()
          pared_nuevo.position(game.at(posX,posY))
          game.addVisual(pared_nuevo)
          sector.objetos().add(pared_nuevo)
      })
  }
  method renderizarHorizontal(posY,pared,rango,sector){ //up o down
      rango.forEach({posX=>
        const pared_nuevo=pared.generar()
        pared_nuevo.position(game.at(posX,posY))
        game.addVisual(pared_nuevo)
      })
  }

  
  method renderizarCon(salida,lado,destino_,sector,ubicacionPersonaje){ //emergencia/final/comun - izqDerSupInf - renderiza salida y el costado
    const imgs=salida.get(lado)
    const posiciones=lado.posiciones()
    const s1 = new Salida(image=imgs.first(),position=posiciones.first(),destino=destino_,ubicacion=ubicacionPersonaje)
    const s2 = new Salida(image=imgs.last(),position=posiciones.last(),destino=destino_,ubicacion=ubicacionPersonaje)
    //new Obstaculo(image=imgs.first(),position=posiciones.first())
    //const s2 = new Obstaculo(image=imgs.last(),position=posiciones.last())
    game.addVisual(s1)
    game.addVisual(s2)

    s1.analizarCambioSector()
    s2.analizarCambioSector()
    sector.objetos().add(s1)
    sector.objetos().add(s2)
    lado.renderizar(self,sector)

  }
 
}





