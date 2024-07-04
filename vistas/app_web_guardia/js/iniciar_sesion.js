document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', async function(event) {
            event.preventDefault();
            const correo = document.getElementById('email').value;
            const contrasena = document.getElementById('password').value;

            if (!correo || !contrasena) {
                alert('Por favor, completa todos los campos.');
                return;
            }

            const response = await fetch('/api/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ correo, contrasena })
            });

            if (response.ok) {
                const data = await response.json();
                console.log('Tipo de Usuario:', data.tipo_usuario);
                window.location.href = 'sede.html';
            } else {
                console.error('Error en la autenticación');
                alert('Autenticación fallida. Por favor verifica tus credenciales.');
            }
        });
    } else {
        console.error('No se encontró el formulario de inicio de sesión.');
    }
});
