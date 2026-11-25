# 1. Imagen base oficial ligera de Python
FROM python:3.11-slim

# 2. Variables de entorno para optimizar Python en contenedores
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. Carpeta de trabajo dentro del contenedor
WORKDIR /app

# 4. Copiar e instalar dependencias primero (aprovecha la cache de Docker)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar el codigo de la aplicacion y los datos
COPY . .

# 6. Exponer el puerto de Streamlit
EXPOSE 8501

# 7. Comando para arrancar el dashboard
ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0", "--server.headless=true", "--browser.gatherUsageStats=false"]
