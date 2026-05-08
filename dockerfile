# Etapa de ejecución: Nginx Alpine (Eficiencia Cero Desperdicio)
FROM nginx:alpine

# Seguridad Zero-Trust: Configuración de permisos para usuario no root
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid /var/cache/nginx /var/log/nginx /etc/nginx/conf.d

# Copia de configuración optimizada
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Directorio de trabajo y despliegue de archivos
WORKDIR /usr/share/nginx/html
COPY index.html .
COPY assets/ ./assets/

# Ejecución bajo usuario no privilegiado
USER nginx

# Exponer el puerto de escucha interno
EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]