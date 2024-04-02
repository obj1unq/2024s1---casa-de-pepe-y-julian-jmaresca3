object casaDePepeYJulian{
	var viveres = 50
	var montoReparaciones = 0
	var reparaciones = false
	
	method romperAlgoDe(unMonto){
		montoReparaciones += unMonto
		reparaciones = true
	}
	
	method viveres(_viveres){
		viveres = _viveres
	}
	
	method montoReparaciones(){
		return montoReparaciones
	}
	
	method suficientesViveres(){
		return viveres>40
	}
	
	method reparaciones(estado){
		reparaciones = estado
	}
	
	method necesitaReparaciones(){
		return reparaciones
	}
	
	method estaEnOrden(){
		return self.suficientesViveres() and (not self.necesitaReparaciones())
	}
}

//////CUENTAS BANCARIAS//////

object cuentaCorriente{
	var saldo = 0
	
	method extraer(importe){
		saldo -= importe
	}
	method depositar(importe){
		saldo += importe
	}
	method saldo(){
		return saldo
	}
}

object cuentaConGastos{
	var saldo = 0
	var costoPorOperacion = 0
	
	method extraer(importe){
		saldo -= importe
	}
	
	method depositar(importe){
		saldo += (importe - costoPorOperacion)
	}
	
	method saldo(){
		return saldo
	}
	
	method costoPorOperacion(_costoPorOperacion){
		costoPorOperacion = _costoPorOperacion
	}
}