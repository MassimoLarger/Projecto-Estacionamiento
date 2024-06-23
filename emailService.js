import nodemailer from 'nodemailer';

export async function sendVerificationEmail(email, code) {
  // Configura el transporter
  let transporter = nodemailer.createTransport({
    service: 'Gmail',  // Puedes usar otros servicios
    auth: {
      user: process.env.EMAIL_USER, // Tu correo electrónico completo
      pass: process.env.EMAIL_APP_PASSWORD, // Contraseña específica de la aplicación generada
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
  await transporter.sendMail(mailOptions);
}
