import simulacion.*

class Persona {
	var property estaAislada = false
	var property contagiado = false
	var property seInfectoDia = null
	var property tieneSintomas = false
	var property respetaCuarentena = false
	var property recuperado = false	
	
	method estaInfectada() {return contagiado}
	
	method infectarse() {
		contagiado = true
		seInfectoDia = simulacion.diaActual()
	}

	method diaQueSeInfecto(){
		if(self.estaInfectada()){
			return seInfectoDia
		} else {
			return "No esta infectada"
		}
	}
	
	method aislar(){estaAislada = true}
	
	method aislade(){return estaAislada}
	
	method convencerDeRespetarCuarentena(){respetaCuarentena = true}
	
	method respetaCuarentena(){return respetaCuarentena}
	
	method presentarSintomas(){tieneSintomas = true}
	
	method presentaSintomas(){return tieneSintomas}
	
	method cumplioCiclo(){
		if(self.estaInfectada()){
			return (simulacion.diaActual() - self.seInfectoDia()) >= simulacion.duracionInfeccion()
		} else {
			return false
		}
	}

	method curar(){
		contagiado = false
		recuperado = true
		tieneSintomas = false
	}
	
	method seRecupero(){return recuperado}

}

