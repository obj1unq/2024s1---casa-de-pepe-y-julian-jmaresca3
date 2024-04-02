object casaDePepeYJulian{
	var property viveres = 50
	var montoReparaciones = 0
	var reparaciones = false
	var cuentaBancaria = cuentaCorriente
	var estrategia
	
	method romperAlgoDe(unMonto){
		montoReparaciones += unMonto
		reparaciones = true
	}
	
	method montoReparaciones() = return montoReparaciones
	
	method suficientesViveres() = return self.viveres()>40
	
	method reparaciones(estado){
		reparaciones = estado
	}
	
	method necesitaReparaciones(){
		return reparaciones
	}
	
	method estaEnOrden(){
		return self.suficientesViveres() and (not self.necesitaReparaciones())
	}
	
	method cuentaBancaria(_cuentaBancaria){
		cuentaBancaria = _cuentaBancaria
	}
	
	method gastar(importe){
		cuentaBancaria.extraer(importe)
	}
	method depositarEnCuenta(importe) {
		cuentaBancaria.depositar(importe) 
	}
	method saldoEnCuenta() = return cuentaBancaria.saldo()
	
	method estrategia(_estrategia){
		estrategia = _estrategia
	}
	method realizarMantenimiento() = estrategia.realizarMantenimiento(self)	
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
	method saldo() = return saldo
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
	
	method saldo() = return saldo
	
	method costoPorOperacion(_costoPorOperacion){
		costoPorOperacion = _costoPorOperacion
	}
}

object cuentaCombinada{
	var property cuentaPrimaria
	var property cuentaSecundaria
	
	method extraer(importe){
		if (cuentaPrimaria.saldo()>importe){
			cuentaPrimaria.extraer(importe)
		} else {
			cuentaSecundaria.extraer(importe)
		}
	}
	method depositar(importe) = cuentaPrimaria.depositar(importe)
	
	method saldo() = return cuentaPrimaria.saldo() + cuentaSecundaria.saldo()
}

//////ESTRATEGIAS DE AHORRO//////

object minimoEIndispensable{
	var property calidad = 1
	
	method realizarMantenimiento(casa){
		if(not casa.suficientesViveres()){
			casa.gastar(self.gastoDeComprarViveres(casa))
		}
	}
	method gastoDeComprarViveres(casa) = return self.porcentajeAComprar(casa)*self.calidad()
	method porcentajeAComprar(casa) = return 40-casa.viveres()
}

object full{
	const calidad = 5
	
	method realizarMantenimiento(casa){
		if(casa.estaEnOrden()){
			casa.gastar(self.gastoDeComprarViveresRestantes(casa))
		}else{
			casa.gastar(self.comprarViveres(40, casa))
		}
	}
	method comprarViveres(porcentaje, casa){
		return porcentaje*calidad
	}
	method gastoDeComprarViveresRestantes(casa) = return self.porcentajeAComprar(casa)*calidad
	method porcentajeAComprar(casa) = return 100-casa.viveres()
}