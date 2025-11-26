# SIG Sanifum

Sistema de gestión para asignación de servicios y técnicos.

## Requisitos

### 1. Python 3.11+
### 2. Instalar dependencias
```
pip install -r requirements.txt
```

### 3. Base de Datos
- Crear BD MySQL: `sig_sanifum`
- Importar:
```
mysql -u usuario -p sig_sanifum < base_de_datos_SANIFU.sql
```

## Ejecutar el sistema
```
python app.py
```

El backend quedará disponible en:
http://127.0.0.1:5000
