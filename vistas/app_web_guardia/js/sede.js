document.addEventListener('DOMContentLoaded', function() {
  var userNameDisplay = document.getElementById('userNameDisplay');
  var userIcon = document.getElementById('userIcon');

  // Recuperar el nombre de usuario de localStorage
  var userEmail = localStorage.getItem('userEmail');
  if (userEmail) {
      // Aquí podrías hacer una solicitud al servidor para obtener más datos del usuario o simplemente mostrar el correo
      userNameDisplay.textContent = userEmail; // Mostrar el correo del usuario como su nombre
  } else {
      userNameDisplay.textContent = 'Usuario no definido';
      console.log('Correo de usuario no encontrado en localStorage.');
  }

  if (!userIcon) {
      console.error("Ícono de usuario no encontrado.");
  } else {
      userIcon.addEventListener('click', function(event) {
          event.stopPropagation();
          console.log("Ícono de usuario clickeado.");
          Swal.fire({
              title: 'Opciones de Usuario',
              showConfirmButton: false,
              html: `
                  <button onclick="editarPerfil()">Editar Perfil</button>
                  <button onclick="cerrarSesion()">Cerrar Sesión</button>
              `
          });
      });
  }
});

function editarPerfil() {
  console.log('Función editarPerfil llamada');
  alert('Editar Perfil');
}

function cerrarSesion() {
  console.log('Función cerrarSesion llamada');
  localStorage.removeItem('userEmail'); // Limpiar el correo del localStorage al cerrar sesión
  window.location.href = 'iniciar_sesion.html'; // Redirigir al usuario a la página de inicio de sesión
}
