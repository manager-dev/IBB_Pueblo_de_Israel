---
proyecto: Portal Institucional Iglesia Bíblica Bautisca Pueblo de Israel
estado: Fase 1 (Legacy HTML) -> Planificación Fase 2 (Astro Migración)
progreso: 15% (Estructura Base Completada)
última_actualización: 2026-05-17
tags:
  - nginx-alpine
  - tailwind-cdn
  - docker-compose
  - edge-computing
  - esit
---

# 🏛️ Portal Web Institucional - Iglesia Bíblica Bautista Pueblo de Israel
## 📋 Proyecto de Servicio Social Universitario
### 🎓 Técnico Superior Universitario en Servicios en la Nube | ESIT

---
### 🛡️ Estado de Infraestructura Actual vs. Objetivo
![Current Stage: HTML5](https://img.shields.io/badge/Current-HTML5%20%252B%20TailwindCDN-orange?style=for-the-badge&logo=html5) ![Target Stage: Astro](https://img.shields.io/badge/Target-Astro%20%252B%20SolidJS-purple?style=for-the-badge&logo=astro) ![Runtime: Docker](https://img.shields.io/badge/Runtime-Docker%20Alpine-blue?style=for-the-badge&logo=docker)

---

> [!IMPORTANT]
> **AUDITORÍA TÉCNICA DE LAVERSIÓN ACTUAL (V1.0-LEGACY):**
> 
> El repositorio contiene actualmente un despliegue estático monolítico basado en HTML5 puro maquetado con **Tailwind CSS vía CDN** y servido mediante un contenedor optimizado de **Nginx Alpine**. Este documento establece la radiografía del código base real subido y traza la ruta crítica de refactorización hacia la arquitectura desacoplada de alto rendimiento (Astro + Bun + Solid.js) dictada por la constitución de nuestro `Digital_Brain`.

---
## ⚡ Resumen Ejecutivo del Estado del Proyecto

Este repositorio alberga el código fuente, la configuración de infraestructura y el entorno contenerizado del sitio web institucional para la **Iglesia Bíblica Bautista Pueblo de Israel**, ubicada en **Soyapango, San Salvador, El Salvador**. 

El desarrollo y despliegue de este activo digital ha sido planificado e implementado como cumplimiento del **Servicio Social obligatorio** para la carrera de **Técnico Superior Universitario (TSU) en Servicios en la Nube** de la **Escuela Superior de Innovación y Tecnología (ESIT)**. El propósito fundamental es dotar a la congregación de una plataforma web moderna, segura, optimizada para redes de ancho de banda restringido y de alta disponibilidad, permitiendo la difusión de sus doctrinas, horarios de cultos, ubicación y la conexión directa con su canal oficial de producción audiovisual en YouTube tras más de 25 años de servicio comunitario.

---

## 🚀 Repositorio y Enlaces Oficiales
* **Repositorio de Producción (GitHub):** [https://github.com/manager-dev/IBB_Pueblo_de_Israel](https://github.com/manager-dev/IBB_Pueblo_de_Israel)
* **Sitio Web Activo (Producción):** [https://pueblodeisrael.portalweb.cc/](https://pueblodeisrael.portalweb.cc/)
* **Entidad Receptora:** Dirección y Administración - Iglesia Bíblica Bautista Pueblo de Israel / Colegio Johan Kepler.
* **Responsable Institucional:** Licenciada Flor de María Hernández.

---

## 🛠️ Fase 1: Arquitectura Actual (MVP Vanilla & Contenerizado)

La implementación inicial se rige bajo la filosofía de **Cero Desperdicio (Zero-Waste Engine)** y **FinOps preventivo**, maximizando la velocidad de respuesta del cliente y reduciendo a niveles mínimos el consumo de CPU, memoria y almacenamiento en el servidor host.

### 1. Frontend Estático (Vanilla Stack)
* **Estructura (`index.html`):** El portal está construido con HTML5 semántico puro y CSS3 nativo inyectado en línea (`<style>`). Esto elimina peticiones HTTP redundantes para hojas de estilo externas, reduciendo el tiempo de renderizado primario (First Contentful Paint - FCP).
* **Tokens de Diseño (Design Tokens):** Se parametrizó la identidad visual de la iglesia mediante variables CSS (`:root`), garantizando un esquema cromático coherente y facilidad de mantenimiento:
  * Azul Institucional (`--primary: #0f2a4a`)
  * Naranja Terracota de Acento (`--secondary: #c05621`)
  * Fondo Limpio y Confortable (`--bg-main: #f9fafb`)
* **Accesibilidad (a11y) y Multimedia:** Inclusión de etiquetas semánticas de navegación (`<nav aria-label="Navegación Principal">`), escalado fluido de imágenes a su resolución natural (`height: auto`) y bloques de contenido asíncronos para la inserción segura de mapas interactivos y llamadas a la acción (*Call-To-Action*) dedicadas al canal de YouTube.

### 2. Configuración del Servidor Web (`nginx.conf`)
El servidor proxy/web Nginx ha sido configurado a medida para responder bajo estrictos parámetros enterprise de rendimiento:
* **Seguridad Ofensiva Basada en Ocultamiento:** La directiva `server_tokens off;` deshabilita la firma de versión de Nginx en los encabezados HTTP, bloqueando ataques dirigidos por escaneo automatizado.
* **Compresión Activa Gzip:** Habilitada para tipos mime clave (`text/plain`, `text/css`, `application/json`, `application/javascript`, `text/xml`), compactando el peso de transferencia en la red móvil local de Soyapango.
* **Políticas FinOps de Caché:** Inyección de la cabecera `Cache-Control "public, immutable"` con expiración de un año (`expires 1y;`) para los recursos de `/assets/`, reduciendo el consumo de ancho de banda del servidor web ante visitas recurrentes.
* **Cabeceras de Endurecimiento (Hardening Headers):**
  * `X-Frame-Options "SAMEORIGIN"`: Previene ataques de Clickjacking.
  * `X-XSS-Protection "1; mode=block"`: Activa filtros contra Cross-Site Scripting.
  * `X-Content-Type-Options "nosniff"`: Fuerza al navegador a respetar estrictamente los tipos MIME declarados.

### 3. Aislamiento e Infraestructura (`Dockerfile` & `docker-compose.yml`)
* **Base Mínima:** Uso de `nginx:alpine`, una distribución Linux basada en Alpine con un tamaño de imagen marginal y una superficie de vulnerabilidades sumamente reducida.
* **Modelo Zero-Trust (No-Root User):** El `Dockerfile` rompe el estándar por defecto al reconfigurar permisos internos para directorios de caché, logs y PID, permitiendo que el proceso corra bajo el usuario no privilegiado `USER nginx`. Esto bloquea el riesgo de compromiso del sistema host a través de una brecha en el contenedor.
* **Límites de Recursos Críticos:** Orquestado en Docker Compose con un límite físico inquebrantable de hardware:
  * **CPU:** Máximo `0.25` (25% de un solo núcleo).
  * **Memoria RAM:** Máximo `64MB`.
* **Red y Puertos:** Exposición interna en el puerto `8080`, mapeado al puerto de red perimetral `8081` de la IP local estática del servidor host Ubuntu (`192.168.1.90`).

---

## 🔄 Fase 2: Hoja de Ruta de Evolución (Bun + Astro + Solid.js)

Para resolver la falta de modularidad que supone un archivo estático masivo y permitir un crecimiento sostenible del sitio hacia subpáginas (ministerios de niños, jóvenes, escuela dominical, histórico de sermones en audio), se ha diseñado la migración hacia una **Arquitectura Jamstack Moderna**.

[Flujo de Compilación y Arquitectura Futura] ⚙️ Bun Runtime ──> 🚀 Astro (SSG / Islas) ──> ⚛️ Solid.js Components

### 1. Bun como Motor y Gestor
Se sustituirá el ecosistema pesado de Node.js por **Bun**. Esto garantizará:
* Instalación de dependencias hasta 20 veces más veloz en entornos locales y en los runners de GitHub Actions (CI/CD).
* Ejecución de tareas de compilación (*builds*) ultrarrápidas disminuyendo el tiempo de despliegue continuo.

### 2. Astro como Framework de Compilación Estática (SSG)
Astro permitirá modularizar el sitio actual mediante la **Arquitectura de Islas (Islands Architecture)**:
* El código actual se dividirá en componentes limpios y reutilizables: `Navbar.astro`, `Hero.astro`, `MissionVision.astro`, `ScheduleTable.astro`, `Footer.astro`.
* **0% JavaScript por defecto:** El resultado final compilado por Astro seguirá siendo HTML estático puro de cero peso, manteniendo el rendimiento excepcional demostrado en la Fase 1.

### 3. Solid.js para Interactividad Quirúrgica
Cuando el portal requiera lógica en el cliente (como un buscador dinámico de sermones, un filtro interactivo por días para las actividades o alertas de transmisiones en vivo):
* Se integrará **Solid.js** en lugar de frameworks pesados como React o Vue.
* Al usar reactividad real sin un DOM virtual (*Virtual DOM*), el peso compilado de los componentes interactivos se reducirá a pocos kilobytes, idóneo para la demografía y condiciones de conectividad de los usuarios finales en Soyapango.

---

## 📂 Árbol Estructural del Proyecto

```

IBB_Pueblo_de_Israel/ 
├── .gitignore         # Filtro estricto para evitar indexación de basura local e IDEs
├── assets/            # Archivos multimedia institucionales (Imágenes del santuario) 
│   ├── 2026.jpg       # Banner promocional del lema "Año del Cambio" 
│   └── interno.jpg    # Fotografía estructural interna del auditorio
├── Dockerfile         # Configuración multicapa segura (Runtime Nginx Alpine No-Root)
├── docker-compose.yml # Declaración de servicios, puertos y límites de CPU/RAM ├── index.html         # Código fuente base del portal (Fase 1 - Vanilla HTML5)
├── nginx.conf         # Reglas de enrutamiento, compresión Gzip y cabeceras de seguridad
└── README.md          # Documentación técnica e institucional del Servicio Social

````

---

## ⚙️ Instrucciones de Operación e Instalación Local

### Prerrequisitos
* **Docker Engine** v20.10+ instalado.
* **Docker Compose** v2.0+ instalado.

### 1. Clonar el Entorno Institucional
```bash
git clone [https://github.com/manager-dev/IBB_Pueblo_de_Israel.git](https://github.com/manager-dev/IBB_Pueblo_de_Israel.git)
cd IBB_Pueblo_de_Israel
````

### 2. Inicialización y Construcción del Contenedor

Para compilar la imagen optimizada con las directivas de seguridad locales y levantar el servicio en segundo plano, ejecuta:

Bash

```
docker compose up --build -d
```

### 3. Monitoreo y Verificación de Límites

Para comprobar que el contenedor está respondiendo correctamente dentro de los parámetros de aislamiento de hardware asignados (`64MB` de RAM y `25%` de CPU), ejecuta:

Bash

```
docker stats ibb_pueblo_israel
```

### 4. Apagado de la Infraestructura local

Para detener el contenedor de forma segura y remover las interfaces de red virtuales temporales:

Bash

```
docker compose down
```

---

_Desarrollado, documentado y administrado por **Rickelmy Josepf Cubías Alvarado** como entregable de Servicio Social para la Escuela Superior de Innovación y Tecnología (ESIT)._