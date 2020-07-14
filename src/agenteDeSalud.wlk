import manzanas.*
import personas.*
import wollok.game.*
import simulacion.*

object agenteDeSalud{  
	
	var property position
	
	method image(){ return "pd.png"}
	
	method position(x,y){
		position = game.at(x,y)
	}
	
	method moveteArriba(){self.position(self.position().up(1))}	
	
	method moveteDerecha(){self.position(self.position().right(1))}	
	
	method moveteIzquierda(){self.position(self.position().left(1))}	
	
	method moveteAbajo(){self.position(self.position().down(1))}
	
	method aislarATodes(){
		simulacion.manzanaEnPosicion(self.position()).infectadesYConSintomas().forEach({p => p.aislar()})
	}
	
	method convencerAManzanaDeRespetarCuarentena(){
		simulacion.manzanaEnPosicion(self.position()).personas().forEach({pers => pers.convencerDeRespetarCuarentena()})
	}
		
}
