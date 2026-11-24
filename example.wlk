class Obra {
  const montoEscandaloso = 8
  const proveedores = #{}
  var montoBase

  method proveedores() = proveedores

  method cantidadProveedores() = self.proveedores().size()

  method costoTotal() = montoBase + self.montoAdicional()

  method trabaja(proveedor) = proveedores.contains(proveedor)

  method esEscandalosa() = self.costoTotal() > montoEscandaloso

  method aumentarMontoBase(monto) {
    montoBase += monto
  }

  method montoAdicional()
}

class Caneria inherits Obra {
  const esDeUrgencia
  const montoUrgente = 0.3
  const montoNoUrgente = 0.1

  override method montoAdicional() = if(esDeUrgencia) montoUrgente else montoNoUrgente
}

object ascensor inherits Obra(montoBase=5) {
  const montoConPocosProveedores = 1.5

  override method proveedores() = #{"el plomero Ramon", "Cacho Electricidad"}

  override method montoAdicional() = if(self.tienePocosProveedores()) montoConPocosProveedores else 0

  method tienePocosProveedores() = self.cantidadProveedores() <= 2
}

class Integral inherits Obra {
  const subObras = #{}

  method agregarObra(nuevaObra) {
    subObras.add(nuevaObra)
  }

  override method montoAdicional() = subObras.sum({obra => obra.montoAdicional()})
}

class Tradicional {
  const palabrasClave = #{"humedad", "ascensor", "ruidos"}
  const proveedoresAmigos = #{}

  method agregarPalabraClave(nuevaPalabra) {
    palabrasClave.add(nuevaPalabra)
  }

  method agregarProveedorAmigo(proveedorAmigo) {
    proveedoresAmigos.add(proveedorAmigo)
  }

  method validarObra(obra, administrador) {
    if(not self.tieneAlgunProveedorAmigoEnObra(obra)) throw new DomainException(message="Debe haber algun proveedor amigo en obra")
  }

  method tieneAlgunProveedorAmigoEnObra(obra) = proveedoresAmigos.any({proveedor => obra.trabaja(proveedor)})

  method aceptaReclamoInmediatamente(reclamo) = palabrasClave.any({palabra => reclamo.contieneEnDescripcion(palabra)})
}

object profesional {
  method validarObra(obra, administrador) {
    if(not self.tieneFondosSuficientes(obra, administrador)) throw new DomainException(message="Debe contar con mas del 60% del costo total de la obra.")
  }

  method tieneFondosSuficientes(obra, administrador) = administrador.fondoDeReserva() > obra.costoTotal() * 0.6

  method aceptaReclamoInmediatamente(reclamo) = reclamo.esCorto()
}

class Administrador {
  const property fondoDeReserva
  const obrasAprobadas = #{}
  const compromisos = #{}
  var modalidad

  method evaluarReclamo(reclamo) {
    if(not modalidad.aceptaReclamoInmediatamente(reclamo)) reclamo.posponerFechaDeResolucion(2)

    compromisos.add(reclamo)
  }

  method aprobarObra(obra) {
    self.validarFondoDeReserva()
    modalidad.validarObra(obra, self)

    obrasAprobadas.add(obra)
  }

  method validarFondoDeReserva() {
    if(fondoDeReserva <= 0) throw new DomainException(message="No se puede aprobar una obra sin fondos de reserva")
  }

  method cambiarModalidad(nuevaModalidad) {
    modalidad = nuevaModalidad
  }

  method obrasEscandalosas()= obrasAprobadas.filter({obra => obra.esEscandalosa()})

  method registrarSubaDeMateriales() {
    obrasAprobadas.forEach({obra => obra.aumentarMontoBase(0.2)})
  }
}

class Reclamo {
  const descripcion
  const fechaDePresentacion
  var fechaDeResolucion

  method contieneEnDescripcion(palabra) = descripcion.contains(palabra)

  method esCorto() = (fechaDeResolucion - fechaDePresentacion) < 90

  method posponerFechaDeResolucion(anios) {
    fechaDeResolucion = fechaDeResolucion.plusYears(anios)
  }
}