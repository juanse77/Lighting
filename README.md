<h1>Iluminación 3D:</h1>

<p>Este práctica consitió en la composición de una escena con objetos tridimensionales y que utilizase texturas, luces y movimientos de cámara. La escena escogida consta de un sistema Tierra-Luna en el interior de un prisma horizontal sin tapas. El prisma está revestido de una textura de muro de ladrillos. Para la cámara se ha utilizado una librería disponible para processig llamada Obsessive Camera Direction (OCD). Se ha utilizado esta librería debido a lo sencillo que resulta el control de su cámara.</p>


<h2>Controles:</h2>

<ul>
	<li>Rotar la cámara derecha/izquierda: flechas derecha/izquerda.</li>
	<li>Rotar la cámara arriba/abajo: flechas arriba/abajo.</li>
	<li>Hacer zoom: ampliar tecla a, alejar tecla s.</li>
	<li>Modificar la luz de ambiente: mover ratón derecha/izquierda.</li>
	<li>Modificar la emisión de luz: mover ratón arriba/abajo.</li>
	<li>Mostrar/Ocultar menú: tecla m.</li>
	<li>Pausar: tecla espacio.</li>
	<li>Salir: Escape.</li>
</ul>

<h2>Detalles de implementación:</h2>

<p>En el control de la cámara se han hecho uso tres métodos: arc, circle, y zoom. El método arc rota la cámara sobre el eje X a través de una circunferencia centrada en el punto de interés que en este caso será el centro del planeta Tierra. El método circle hace lo mismo pero rota sobre el eje Y. El método zoom acerca o aleja la vista de la cámara sin desplazarla de su lugar, el avance del zoom se detiene al encontrar un objeto.</p>

<p>Al iniciarse la aplicación se presenta en el centro de la pantalla un menú con la descripción de los controles disponibles. El acceso al menú se puede hacer en cualquier momento pulsando la tecla m. En las sucesivas llamadas al menú, la cámara es recolocada en su posición original haciendo uso del método jump, del mismo modo el zoom que se haya acumulado durante la actividad de usuario se deshace para que la vista del menú no quede desproporcionada.</p> 

<p>Los métodos utilizados para controlar la iluminación fueron: directionalLight, ambientLight, spotLight, emissive, lightSpecular y shininess. La luz principal de la escena se consiguió con la utilización del método directionalLight. La dirección de la luz que se escogió fue la (-1, -0.2, 0.2) que podría corresponderse con una iluminación de invierno en el emisferio norte. El color de esta luz se escogió que fuera completamente blanca.</p>

```java
directionalLight(255, 255, 255, -1, -0.2, 0.2);
```

<p>Con la luz de ambiente y el movimiento horizontal del ratón se ha creado un efecto en el que se puede iluminar la escena de un gradiente de rojo a azul desplando el ratón de izquerda a derecha.</p>

```java
float val_ambiente_rojo = (float)(width/2 - mouseX) / ((float)width/2) * 255;
float val_ambiente_azul = 0;
  
if(val_ambiente_rojo < 0){
	val_ambiente_azul = -val_ambiente_rojo;
	val_ambiente_rojo = 0;
}
  
ambientLight((int)val_ambiente_rojo, 0 , (int)val_ambiente_azul);
```

<p>Otro efecto interesante que se ha logrado ha sido la creación de un punto de luz amarillento que recorre la cara iluminada del planeta tierra al verse ensombrecido por el paso de la Luna. El efecto se consiguió utilizando el método spotLight con un punto de origen en la luna y un vector de proyección en la misma dirección de la emisión de la luz blanca principal.</p>

```java
Punto pos_luna = luna.getPosicionRelativa();
spotLight(255, 255, 0, pos_luna.getX() + width/2, pos_luna.getY() + height/2, pos_luna.getZ(), -1, -0.2, 0.2, PI/16, 100);
```

<p>Se han probado con menos éxito los efectos de luz especular, y el método shininess. Para la luz especular se intentó un efecto parecido al de la luz ambiente pero con el movimiento vertical del ratón. El método shininess no parece producir ningún efecto observable.</p>

```java
float val_specular = (float)abs(height/2 - mouseY) / ((float)height/2) * 255;
lightSpecular((int)val_specular, 0, 0);

shininess(100.0);
```

<p>Por último se probó el efecto anterior con el método emissive logrando un efecto curioso, al combinarse con el efecto de luz ambiente.</p>

```java
float val_emissive = (float)abs(height/2 - mouseY) / ((float)height/2) * 255;
emissive(0, val_emissive, 0); 
```

<div align="center">
	<p><img src="./Lighting_3D.gif" alt="Sistema solar interactivo 3D" /></p>
</div>

<p>Esta aplicación se ha desarrollado como quinta práctica evaluable para la asignatura de "Creando Interfaces de Usuarios" de la mención de Computación del grado de Ingeniería Informática de la Universidad de Las Palmas de Gran Canaria en el curso 2019/20 y en fecha de 16/3/2020 por el alumno Juan Sebastián Ramírez Artiles.</p>

<p>Referencias a los recursos utilizados:</p>

- Modesto Fernando Castrillón Santana, José Daniel Hernández Sosa. [Creando Interfaces de Usuario. Guion de Prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/25/CIU_Pr_cticas.pdf)
- Processing Foundation. [Processing Reference.](https://processing.org/reference/)
- [Obsessive Camera Direction (OCD)](http://gdsstudios.com/processing/libraries/ocd/).
- [Textura de la Tierra](https://canelonesconcodigo.wordpress.com/2014/11/09/tierra-con-three-js/).
- [Textura de la Luna](https://www.canstockphoto.es/superficie-seamless-textura-luna-35589436.html).
- [Textura del muro](http://bgfons.com/download/3452).