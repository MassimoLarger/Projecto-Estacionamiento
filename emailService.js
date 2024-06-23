import nodemailer from 'nodemailer';

export async function sendVerificationEmail(email, code) {
  // Verifica que las variables de entorno estén definidas
  if (!process.env.EMAIL_USER || !process.env.EMAIL_APP_PASSWORD) {
    console.error('Las variables de entorno EMAIL_USER y EMAIL_APP_PASSWORD deben estar definidas.');
    throw new Error('Configuración de correo electrónico no encontrada.');
  }

  // Verifica que el destinatario no esté vacío
  if (!email) {
    console.error('No se ha proporcionado un destinatario.');
    throw new Error('Destinatario no definido.');
  }

  // Configura el transporter
  let transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_APP_PASSWORD,
    },
  });

  // Configura el correo
  let mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: 'Código de verificación',
    text: `Tu código de verificación es: ${code}`,
  };

  // Envía el correo
  try {
    await transporter.sendMail(mailOptions);
  } catch (error) {
    console.error('Error al enviar el correo:', error);
    throw new Error('Error al enviar el correo.');
  }
}