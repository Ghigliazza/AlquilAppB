let tiempo_Minutos = 3*24*60 + 23*60 + 58; // 3 dias con 23 horas y 58 minutos
let tiempo_Segundos = tiempo_Minutos * 60;
let dias;
let horas;
let minutos;
let segundos;
let notificación = "Faltan 15 minutos para que se termine el tiempo."

var aviso = setInterval(function mostrar_Tiempo() {

tiempo_Segundos--;

dias = Math.floor(tiempo_Segundos/(60*24*60));
horas = Math.floor(tiempo_Segundos/(60*60));
minutos = Math.floor(tiempo_Segundos/60);
segundos = Math.floor(tiempo_Segundos);

horas = horas - dias*24;
minutos = minutos - (dias*24*60 + horas*60);
segundos = segundos - (dias*24*60*60 + horas*60*60 + minutos*60);

if (tiempo_Segundos > 0) {

document.getElementById('dias').innerHTML = dias + " dias";
document.getElementById('horas').innerHTML = horas + " horas";
document.getElementById('minutos').innerHTML = minutos +  " minutos";
document.getElementById('segundos').innerHTML = segundos + " segundos";

}

else {
document.getElementById('fin_De_Alquiler').innerHTML = "Se terminó el tiempo.";
clearInterval(aviso);
}

if (minutos == 15) {
document.getElementById('notificacion_15_Minutos').innerHTML = notificacion;
}

},1000)