<h1>Iluminaci�n 3D:</h1>

<p>Este pr�ctica consiti� en la composici�n de una escena con objetos tridimensionales y que utilizase texturas, luces y movimientos de c�mara. La escena escogida consta de un sistema Tierra-Luna en el interior de un prisma horizontal sin tapas. El prisma est� revestido de una textura de muro de ladrillos. Para la c�mara se ha utilizado una librer�a disponible para processig llamada Obsessive Camera Direction (OCD). Se ha utilizado esta librer�a debido a lo sencillo que resulta el control de su c�mara.</p>


<h2>Controles:</h2>

<ul>
	<li>Rotar la c�mara derecha/izquierda: flechas derecha/izquerda.</li>
	<li>Rotar la c�mara arriba/abajo: flechas arriba/abajo.</li>
	<li>Hacer zoom: ampliar tecla a, alejar tecla s.</li>
	<li>Modificar la luz de ambiente: mover rat�n derecha/izquierda.</li>
	<li>Modificar la emisi�n de luz: mover rat�n arriba/abajo.</li>
	<li>Mostrar/Ocultar men�: tecla m.</li>
	<li>Pausar: tecla espacio.</li>
	<li>Salir: Escape.</li>
</ul>

<h2>Detalles de implementaci�n:</h2>

<p>En el control de la c�mara se han hecho uso tres m�todos: arc, circle, y zoom. El m�todo arc rota la c�mara sobre el eje X a trav�s de una circunferencia centrada en el punto de inter�s que en este caso ser� el centro del planeta Tierra. El m�todo circle hace lo mismo pero rota sobre el eje Y. El m�todo zoom acerca o aleja la vista de la c�mara sin desplazarla de su lugar, el avance del zoom se detiene al encontrar un objeto.</p>

<p>Al iniciarse la aplicaci�n se presenta en el centro de la pantalla un men� con la descripci�n de los controles disponibles. El acceso al men� se puede hacer en cualquier momento pulsando la tecla m. En las sucesivas llamadas al men�, la c�mara es recolocada en su posici�n original haciendo uso del m�todo jump, del mismo modo el zoom que se haya acumulado durante la actividad de usuario se deshace para que la vista del men� no quede desproporcionada.</p> 

<p>Los m�todos utilizados para controlar la iluminaci�n fueron: directionalLight, ambientLight, spotLight, emissive, lightSpecular y shininess. La luz principal de la escena se consigui� con la utilizaci�n del m�todo directionalLight. La direcci�n de la luz que se escogi� fue la (-1, -0.2, 0.2) que podr�a corresponderse con una iluminaci�n de invierno en el emisferio norte. El color de esta luz se escogi� que fuera completamente blanca.</p>

```java
directionalLight(255, 255, 255, -1, -0.2, 0.2);
```

<p>Con la luz de ambiente y el movimiento horizontal del rat�n se ha creado un efecto en el que se puede iluminar la escena de un gradiente de rojo a azul desplando el rat�n de izquerda a derecha.</p>

```java
float val_ambiente_rojo = (float)(width/2 - mouseX) / ((float)width/2) * 255;
float val_ambiente_azul = 0;
  
if(val_ambiente_rojo < 0){
	val_ambiente_azul = -val_ambiente_rojo;
	val_ambiente_rojo = 0;
}
  
ambientLight((int)val_ambiente_rojo, 0 , (int)val_ambiente_azul);
```

<p>Otro efecto interesante que se ha logrado ha sido la creaci�n de un punto de luz amarillento que recorre la cara iluminada del planeta tierra al verse ensombrecido por el paso de la Luna. El efecto se consigui� utilizando el m�todo spotLight con un punto de origen en la luna y un vector de proyecci�n en la misma direcci�n de la emisi�n de la luz blanca principal.</p>

```java
Punto pos_luna = luna.getPosicionRelativa();
spotLight(255, 255, 0, pos_luna.getX() + width/2, pos_luna.getY() + height/2, pos_luna.getZ(), -1, -0.2, 0.2, PI/16, 100);
```

<p>Se han probado con menos �xito los efectos de luz especular, y el m�todo shininess. Para la luz especular se intent� un efecto parecido al de la luz ambiente pero con el movimiento vertical del rat�n. El m�todo shininess no parece producir ning�n efecto observable.</p>

```java
float val_specular = (float)abs(height/2 - mouseY) / ((float)height/2) * 255;
lightSpecular((int)val_specular, 0, 0);

shininess(100.0);
```

<p>Por �ltimo se prob� el efecto anterior con el m�todo emissive logrando un efecto curioso, al combinarse con el efecto de luz ambiente.</p>

```java
float val_emissive = (float)abs(height/2 - mouseY) / ((float)height/2) * 255;
emissive(0, val_emissive, 0); 
```

<div align="center">
	<p><img src="./Lighting_3D.gif" alt="Sistema solar interactivo 3D" /></p>
</div>

<p>Esta aplicaci�n se ha desarrollado como quinta pr�ctica evaluable para la asignatura de "Creando Interfaces de Usuarios" de la menci�n de Computaci�n del grado de Ingenier�a Inform�tica de la Universidad de Las Palmas de Gran Canaria en el curso 2019/20 y en fecha de 16/3/2020 por el alumno Juan Sebasti�n Ram�rez Artiles.</p>

<p>Referencias a los recursos utilizados:</p>

- Modesto Fernando Castrill�n Santana, Jos� Daniel Hern�ndez Sosa. [Creando Interfaces de Usuario. Guion de Pr�cticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/25/CIU_Pr_cticas.pdf)
- Processing Foundation. [Processing Reference.](https://processing.org/reference/)
- [Obsessive Camera Direction (OCD)](http://gdsstudios.com/processing/libraries/ocd/).
- [Textura de la Tierra](https://canelonesconcodigo.wordpress.com/2014/11/09/tierra-con-three-js/).
- [Textura de la Luna](https://www.canstockphoto.es/superficie-seamless-textura-luna-35589436.html).
- [Textura del muro](http://bgfons.com/download/3452).