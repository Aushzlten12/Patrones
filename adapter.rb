# Pago en efectivo o con tarjeta
# Una clase de sistema de ventas con el metodo de procesoPago
class SistemaVenta
  def procesoPago
  end
end


# Una clase para pagar en efectivo que hereda la clase SistemaVenta
class PagoEfectivo < SistemaVenta 
  def procesoPago(cantidadPagar)
    puts "Ha pagado en efectivo la cantidad de $#{cantidadPagar}"
  end
end

# Un adaptador para realizar el pago online
class PagoOnlineAdapter < SistemaVenta
  def initialize(pagoOnline)
    @pagoOnline = pagoOnline
  end

  def procesoPago(cantidadPagar)
    @pagoOnline.hacerPago(cantidadPagar)
  end
end

# Una clase para realizar pagos online que no se hereda de ninguna otra clase, con métodos diferentes
class PagoOnline
  def hacerPago(cantidadPagar)
    puts "Ha pagado de manera online la cantidad de $#{cantidadPagar}"
  end
end

