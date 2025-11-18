import elementos.*

class Enemigo{
    var property position=game.at(4,4)
    //var position = game.at(30,30)
    //var posicion = game.at(0,0)
    method image()="enemigo1.png"

    
    method perseguir(objetivo){
        //var posicion=objetivo.position()
        
        if(objetivo.position().x()>position.x()){
            position=position.right(1)
        }
        if(objetivo.position().x()<position.x()){
            position=position.left(1)
        }
        if(objetivo.position().x()==position.x() && objetivo.position().y()<position.y()){
            position=position.down(1)
        }
        if(objetivo.position().x()==position.x() && objetivo.position().y()>position.y()){
            position=position.up(1)
        }
        //position=position.right(4)
        //if(objetivo.position() == position){self.perseguir(puerta)
        //}
    }
    

}