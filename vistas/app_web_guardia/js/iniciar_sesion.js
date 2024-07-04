document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault(); // Previene la recarga de la página por defecto del formulario

    var rut = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    if (!rut || !password) {
        alert('Por favor, completa todos los campos.');
    } else {
        // Aquí podrías implementar validación adicional o consulta a una API
        window.location.href = 'sede.html'; // Redirige a la página de sede
    }
});

async function iniciarSesion() {
    try {
      const response = await fetch('/api/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
          correo: correoController.text,
          contrasena: contrasenaController.text,
        }),
      });
  
      if (response.status === 200) {
        const responseBody = await response.json();
        if (responseBody.success) {
          // Navegación a otro componente, asumiendo el uso de React Router o similar
          // Esta es una manera simplificada, deberías ajustarlo a tu estructura de navegación
          history.push('/car-selection', { userId: responseBody.userId });
        } else {
          // Usuario no encontrado, muestra mensaje de error
          // Esto asume que existe una función o método para actualizar el estado
          setErrorMensaje(responseBody.message);
        }
      } else {
        // Error en la solicitud
        setErrorMensaje('Error en la solicitud. Inténtalo de nuevo.');
      }
    } catch (error) {
      // Manejo de error en la solicitud
      setErrorMensaje('Error en la solicitud. Inténtalo de nuevo.');
    }
  }
  