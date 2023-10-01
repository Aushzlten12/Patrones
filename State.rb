# Estado si el producto esta agotado o no

class EstadoProducto
  def productoStock
  end
end

class EnStock < EstadoProducto
  def productoStock
    " en stock"
  end
end

class Agotado < EstadoProducto
  def productoStock
    " agotado"
  end
end
